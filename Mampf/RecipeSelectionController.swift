//
//  RecipeSelectionController.swift
//  Mampf
//
//  Created by Fabian Braig on 15.07.17.
//  Copyright © 2017 Fabian Braig. All rights reserved.
//

import UIKit

class RecipeSelectionController: UIViewController, UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate {
    @IBOutlet weak var recipeTableView: UITableView!
    private var cookbook = Cookbook()
    private var allRecipeNames = [String]()
    private var selection: Int = 0
    private var displayedRecipeNames = [String]()
	
  	@IBAction func recipeSearchInit(_ sender: UIBarButtonItem) {
		let searchController = UISearchController(searchResultsController: nil)
		searchController.searchBar.delegate = self
		present(searchController, animated: true, completion: nil)
	}
	
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return displayedRecipeNames.count
    }

    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
		let recipeCell = UITableViewCell(style: UITableViewCellStyle.default, reuseIdentifier: "recipeCell")
		
		if let tmp_image = cookbook.getRecipe(id: displayedRecipeNames[indexPath.row])?.image {
			recipeCell.imageView?.image = tmp_image
		} else {
			recipeCell.imageView?.image = UIImage(named: "MampfLogo")
		}
		
        recipeCell.textLabel?.text = displayedRecipeNames[indexPath.row]
		
		if indexPath.row % 2 == 0 {
			recipeCell.backgroundColor = UIColor.white
		} else {
			recipeCell.backgroundColor = UIColor(red: 0.1, green: 0.1, blue: 0.1, alpha: 0.1)
		}
		recipeCell.selectionStyle = UITableViewCellSelectionStyle.none
		return recipeCell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selection = indexPath.row
        if cookbook.getRecipe(id: displayedRecipeNames[selection]) != nil {
            performSegue(withIdentifier: "ShowRecipeDetail", sender: self)
        }
    }
	
	func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
		if let tempRecipeList = cookbook.getRecipeList(filterBy: searchText) {
			displayedRecipeNames = tempRecipeList
			recipeTableView.reloadData()
		}
	}
	
	func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
		searchBar.resignFirstResponder()
		dismiss(animated: true, completion: nil)
	}
	
	func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
		displayedRecipeNames = allRecipeNames
		recipeTableView.reloadData()
	}
	
    override func viewDidLoad() {
        super.viewDidLoad()
        if let tempRecipeList = cookbook.getRecipeList() {
            allRecipeNames = tempRecipeList
            displayedRecipeNames = allRecipeNames
        }
		self.navigationItem.titleView = UIImageView(image: UIImage(named: "MampfLogoSmallWhite"))
		recipeTableView.tableFooterView = UIView() // show no empty cells
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let recipeDetailController = segue.destination as! RecipeDetailController
		recipeDetailController.recipe = cookbook.getRecipe(id: displayedRecipeNames[selection])
    }
}
