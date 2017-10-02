//
//  RecipeSelectionController.swift
//  Mampf
//
//  Created by Fabian Braig on 15.07.17.
//  Copyright © 2017 Fabian Braig. All rights reserved.
//

import UIKit
import CoreData

class RecipeSelectionController: UIViewController, UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate {
    @IBOutlet weak var recipeTableView: UITableView!
	private var frc: NSFetchedResultsController<Recipe>!
    private var selectedRecipe: Recipe?
    
    private func updateFetchedResultsController(filterBy searchTerm: String? = nil)
    {
        let context = AppDelegate.viewContext
        let request: NSFetchRequest<Recipe> = Recipe.fetchRequest()
        let predicate: NSPredicate
        let sortDescriptor = NSSortDescriptor(key: "name", ascending: true)
        if searchTerm != nil && searchTerm != "" {
            predicate = NSPredicate(format: "ingredients contains[cd] %@", searchTerm!)
        } else {
            predicate = NSPredicate(value: true)
        }
        request.predicate = predicate
        request.sortDescriptors = [sortDescriptor]
        frc = NSFetchedResultsController(fetchRequest: request, managedObjectContext: context, sectionNameKeyPath: nil, cacheName: nil)
        do {
            try frc.performFetch()
        } catch {
            fatalError("Failed to fetch entities: \(error)")
        }
    }
	
  	@IBAction func recipeSearchInit(_ sender: UIBarButtonItem) {
		let searchController = UISearchController(searchResultsController: nil)
		searchController.searchBar.delegate = self
		present(searchController, animated: true, completion: nil)
	}
	
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        if let count = frc.fetchedObjects?.count {
            return count
        } else {
            return 0
        }
    }

    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
		let recipeCell = UITableViewCell(style: UITableViewCellStyle.default, reuseIdentifier: "recipeCell")

        if let tmp_image = frc.object(at: indexPath).image {
            recipeCell.imageView?.image = tmp_image
        } else {
            recipeCell.imageView?.image = UIImage(named: "MampfLogo")
        }

        recipeCell.textLabel?.text = frc.object(at: indexPath).name!
		
		if indexPath.row % 2 == 0 {
			recipeCell.backgroundColor = UIColor.white
		} else {
			recipeCell.backgroundColor = UIColor(red: 0.1, green: 0.1, blue: 0.1, alpha: 0.1)
		}
		recipeCell.selectionStyle = UITableViewCellSelectionStyle.none
		return recipeCell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedRecipe = frc.object(at: indexPath)
        if selectedRecipe != nil {
            performSegue(withIdentifier: "ShowRecipeDetail", sender: self)
        }
    }
	
	func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        updateFetchedResultsController(filterBy: searchText)
        recipeTableView.reloadData()
	}
	
	func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
		searchBar.resignFirstResponder()
		dismiss(animated: true, completion: nil)
	}
	
	func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        updateFetchedResultsController()
		recipeTableView.reloadData()
	}
    
    override func viewDidLoad() {
        super.viewDidLoad()
        RecipeLoader.checkRecipeStatus()
        updateFetchedResultsController()
		self.navigationItem.titleView = UIImageView(image: UIImage(named: "MampfLogoSmallWhite"))
		recipeTableView.tableFooterView = UIView() // show no empty cells
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let recipeDetailController = segue.destination as! RecipeDetailController
        recipeDetailController.recipe = selectedRecipe!
    }
}
