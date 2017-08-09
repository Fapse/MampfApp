//
//  DisplayController.swift
//  Mampf
//
//  Created by Fabian Braig on 15.07.17.
//  Copyright © 2017 Fabian Braig. All rights reserved.
//

import UIKit

class DisplayController: UIViewController {

    @IBOutlet weak var recipeText: UITextView!
    var recipeName = String()
    var recipeInstruction = String()
    var recipeContents = String()
	var test = UIScrollView()
	
        
	override func viewDidLoad() {
		super.viewDidLoad()
		recipeText.attributedText = buildRecipeText()
	}
	
	private func buildRecipeText() -> NSAttributedString {
		let myString = recipeName + "\n" + recipeContents + recipeInstruction
		let myAttributesHeadline: [String: Any] = [NSFontAttributeName: UIFont(name: "Chalkduster", size: 26.0)!,
		                                   NSForegroundColorAttributeName: UIColor.red]
		let myAttributesStandardText: [String: Any] = [NSFontAttributeName: UIFont(name: "Arial", size: 20.0)!,
		                                   NSForegroundColorAttributeName: UIColor.black]
		let myAttrString = NSMutableAttributedString(string: myString)
		let myRangeStandardText = NSRange(location: 0, length: myAttrString.length)
		let myRangeHeadline = NSRange(location: 0, length: recipeName.characters.count)
		myAttrString.addAttributes(myAttributesStandardText, range: myRangeStandardText)
		myAttrString.addAttributes(myAttributesHeadline, range: myRangeHeadline)
		return myAttrString
	}
	
	override func viewDidAppear(_ animated: Bool) {
	}

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
