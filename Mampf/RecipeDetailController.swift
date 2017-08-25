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
    
    var recipeName = String()
    var recipeIngredients = String()
    var recipeInstruction = String()

    @IBAction func swipeRight(_ sender: UISwipeGestureRecognizer) {
        performSegue(withIdentifier: "ShowRecipeSelection", sender: self)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        recipeNameView.text = recipeName
        recipeIngredientsView.text = recipeIngredients
        recipeInstructionView.text = recipeInstruction
        print("now load file: \(recipeName)")
        let image = UIImage(named: recipeName)
        if image != nil {
            recipeImageView.image = image
        } else {
            recipeImageView.removeFromSuperview()
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
