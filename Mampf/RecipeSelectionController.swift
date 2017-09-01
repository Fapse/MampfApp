//
//  RecipeSelectionController.swift
//  Mampf
//
//  Created by Fabian Braig on 15.07.17.
//  Copyright © 2017 Fabian Braig. All rights reserved.
//

import UIKit

class RecipeSelectionController: UIViewController, UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate {
    @IBOutlet weak var recipeSearchBar: UISearchBar!
    @IBOutlet weak var recipeTableView: UITableView!
    private var cookbook = Cookbook()
    private var allRecipeNames = [String]()
    private var selection: Int = 0
    private var displayedRecipeNames = [String]()
    private var isSearching: Bool = false {
		willSet {
			if newValue {
				// search mode activated
				recipeSearchBar.isHidden = false
				recipeSearchBar.becomeFirstResponder()
			} else {
				// search cancelled
				recipeSearchBar.isHidden = true
				recipeSearchBar.text = ""
				recipeSearchBar.resignFirstResponder()
				displayedRecipeNames = allRecipeNames
				recipeTableView.reloadData()
			}
			print("will set isSearching to \(newValue)")
		}
	}
	
  	@IBAction func recipeSearchInit(_ sender: UIBarButtonItem) {
		print("i am pressed")
		isSearching = !isSearching
	}
	
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return displayedRecipeNames.count
    }

    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let recipeCell = UITableViewCell(style: UITableViewCellStyle.default, reuseIdentifier: "recipeCell")
        let image = UIImage(named: displayedRecipeNames[indexPath.row])
        if image != nil {
            recipeCell.imageView?.image = image
        }
        recipeCell.textLabel?.text = displayedRecipeNames[indexPath.row]
        return recipeCell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selection = indexPath.row
        if cookbook.getRecipe(id: displayedRecipeNames[selection]) != nil {
            performSegue(withIdentifier: "ShowRecipeDetail", sender: self)
        }
    }
	
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
		print("Search bar text changed")
		if let tempRecipeList = cookbook.getFilteredRecipeList(searchText) {
			displayedRecipeNames = tempRecipeList
			recipeTableView.reloadData()
		}
	}
	
    override func viewDidLoad() {
        super.viewDidLoad()
        if let tempRecipeList = cookbook.getRecipeList() {
            allRecipeNames = tempRecipeList
            displayedRecipeNames = allRecipeNames
        }
        recipeSearchBar.delegate = self
		recipeSearchBar.isHidden = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let recipeDetailController = segue.destination as! RecipeDetailController
        recipeDetailController.recipeName = displayedRecipeNames[selection]
        recipeDetailController.recipeInstruction = cookbook.getRecipeInstruction(id: displayedRecipeNames[selection])!
        recipeDetailController.recipeIngredients = cookbook.getRecipeIngredients(id: displayedRecipeNames[selection])!
    }
}
