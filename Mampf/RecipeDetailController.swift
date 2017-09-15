//
//  RecipeDetailController.swift
//  Mampf
//
//  Created by Fabian Braig on 17.08.17.
//  Copyright © 2017 Fabian Braig. All rights reserved.
//

import UIKit

class RecipeDetailController: UIViewController {
    
    @IBOutlet weak var recipeImageView: UIImageView!
    @IBOutlet weak var recipeNameView: UITextView!
    @IBOutlet weak var recipeIngredientsView: UITextView!
    @IBOutlet weak var recipeInstructionView: UITextView!
	
	var recipe: Recipe?
	
	override func viewDidLoad() {
		super.viewDidLoad()
		if let tmp_recipe = self.recipe {
			recipeNameView.text = tmp_recipe.name
			recipeIngredientsView.text = tmp_recipe.ingredients
			recipeInstructionView.text = tmp_recipe.instruction
			if tmp_recipe.image != nil {
				recipeImageView.image = tmp_recipe.image
			} else {
				recipeImageView.removeFromSuperview()
			}
		}
	}

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
