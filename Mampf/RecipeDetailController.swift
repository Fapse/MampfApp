//
//  RecipeDetailController.swift
//  Mampf
//
//  Created by Fabian Braig on 17.08.17.
//  Copyright © 2017 Fabian Braig. All rights reserved.
//

import UIKit

class RecipeDetailController: UIViewController {
    

    @IBOutlet weak var recipeNameView: UITextView!
    @IBOutlet weak var recipeIngredientsView: UITextView!
    @IBOutlet weak var recipeInstructionView: UITextView!
    
    var recipeName = String()
    var recipeIngredients = String()
    var recipeInstruction = String()

    override func viewDidLoad() {
        super.viewDidLoad()
        recipeNameView.text = recipeName
        recipeIngredientsView.text = recipeIngredients
        recipeInstructionView.text = recipeInstruction
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
