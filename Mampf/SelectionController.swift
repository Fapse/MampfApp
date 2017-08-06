//
//  SelectionController.swift
//  Mampf
//
//  Created by Fabian Braig on 15.07.17.
//  Copyright © 2017 Fabian Braig. All rights reserved.
//

import UIKit

class SelectionController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    private var cookbook = Cookbook()
    private var recipes = [String]()
    private var selection: Int = 0
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return recipes.count
    }

    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let recipeCell = UITableViewCell(style: UITableViewCellStyle.default, reuseIdentifier: "recipeCell")
        recipeCell.textLabel?.text = recipes[indexPath.row]
        return recipeCell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath.row)
        selection = indexPath.row
        performSegue(withIdentifier: "ShowRecipeDetail", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let recipeDisplayController = segue.destination as! DisplayController
        recipeDisplayController.recipeName = recipes[selection]
        recipeDisplayController.recipeInstruction = cookbook.getRecipeInstructions(id: recipes[selection])
        recipeDisplayController.recipeContents = cookbook.getRecipeIngredients(id: recipes[selection])
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        recipes = cookbook.getRecipeList()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

