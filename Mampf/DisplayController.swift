//
//  DisplayController.swift
//  Mampf
//
//  Created by Fabian Braig on 15.07.17.
//  Copyright © 2017 Fabian Braig. All rights reserved.
//

import UIKit

class DisplayController: UIViewController {

    @IBOutlet weak var recipeTitle: UILabel!
    @IBOutlet weak var recipeText: UITextView!
    var recipeName = String()
    var recipeInstruction = String()
    var recipeContents = String()
        
    override func viewDidLoad() {
        super.viewDidLoad()
        recipeTitle.text = recipeName;
        recipeText.text = recipeContents + recipeInstruction
    }
    
    override func viewDidAppear(_ animated: Bool) {
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
