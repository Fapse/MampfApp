//
//  Cookbook.swift
//  Mampf
//
//  Created by Fabian Braig on 15.07.17.
//  Copyright © 2017 Fabian Braig. All rights reserved.
//

import UIKit
import Foundation

struct Cookbook {
    private var recipeDictionary = [String: Recipe]()
    
    init() {
        importRecipies()
    }
    
    func getRecipe(id: String) -> Recipe? {
        return recipeDictionary[id]
    }
 
    func getRecipeInstruction(id: String) -> String? {
        return recipeDictionary[id]?.instruction
    }
    func getRecipeIngredients(id: String) -> String? {
        return recipeDictionary[id]?.ingredients
    }
	func getRecipeImage(id: String) -> UIImage? {
		return recipeDictionary[id]?.image
	}
    
    func getRecipeList() -> [String]? {
        return Array(recipeDictionary.keys.sorted())
    }
	
    func getFilteredRecipeList(_ searchTerm: String) -> [String]? {
		if searchTerm == "" {
			return getRecipeList()
		}
        var tempArray = [String]()
        let tempDict = recipeDictionary.filter(
			{return $0.value.description.localizedCaseInsensitiveContains(searchTerm)}
		)
        for i in tempDict {
            tempArray.append(i.key)
        }
        return tempArray
    }
    
    private func readCSVFile() -> String? {
        var fullText: String?
        let path = Bundle.main.path(forResource: "recipes", ofType: "csv")
        do {
            //reading
            fullText = try String(contentsOfFile: path!, encoding: String.Encoding.utf8)
        }
        catch {/* error handling*/
            print("error occured")
            print(error.localizedDescription)
        }
        return fullText
    }
    
    private mutating func importRecipies() {
        let rawText = readCSVFile()
        if rawText != nil {
            let delimeter = "\r\n"
            let recipeStrings: [String] = rawText!.components(separatedBy: delimeter)
            for i in 0..<recipeStrings.count
            {
                let recipeParts = recipeStrings[i].components(separatedBy: ";")
                let recipeName = recipeParts[0]
                let recipeIngredients = recipeParts[1].replacingOccurrences(of: ",", with: "\n")
                let recipeInstruction = recipeParts[2]
				let recipeImage = UIImage(named: recipeName)
                
                let recipe = Recipe(name: recipeName, ingredients: recipeIngredients, instruction: recipeInstruction, image: recipeImage)
                if recipe.name != nil {
                    recipeDictionary[recipe.name!] = recipe
                }
            }
        }
    }
}
