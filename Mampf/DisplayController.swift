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
	var test = UIScrollView()
	
        
    override func viewDidLoad() {
        super.viewDidLoad()
		
        recipeTitle.text = recipeName;
		
		recipeText.attributedText = buildRecipeText()
		
        //recipeText.text = recipeContents + recipeInstruction
    }
	
	private func buildRecipeText() -> NSAttributedString {
		let myString = recipeName + "\n" + recipeContents + recipeInstruction
		let myAttributes: [String: Any] = [NSFontAttributeName: UIFont(name: "Chalkduster", size: 25.0)!,
		                                   NSForegroundColorAttributeName: UIColor.red]
		let myAttrString = NSMutableAttributedString(string: myString)
		let myRange = NSRange(location: 0, length: recipeName.characters.count)
		
		myAttrString.addAttributes(myAttributes, range: myRange)
		return myAttrString
	}
	
    override func viewDidAppear(_ animated: Bool) {
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
