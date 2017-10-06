//
//  Cookbook.swift
//  Mampf
//
//  Created by Fabian Braig on 15.09.17.
//  Copyright © 2017 Fabian Braig. All rights reserved.
//

import UIKit
import Foundation
import CoreData

struct RecipeLoader {
    static func checkRecipeStatus() {
        let context = AppDelegate.viewContext
        let request: NSFetchRequest<Recipe> = Recipe.fetchRequest()
        //let sortDescriptor = NSSortDescriptor(key: "name", ascending: true)
        let predicate = NSPredicate(value: true)
        request.predicate = predicate
        //request.sortDescriptors = [sortDescriptor]
        
        var counter: Int = 0
        do {
            counter = try context.count(for: request)
        } catch {
            print("Could not retrieve number of recipes in Core Data")
        }
        if counter == 0 {
            print("Now importing to CoreData")
            importRecipies()
        } else {
            print("There are already some recipes in CoreData")
        }
        //loadJSONData()
        JsonRecipeLoader.loadJsonRecipes()
    }
	
    private static func loadJSONData() {
		let url = URL(string: "file:///Volumes/Public/Mampf/recipes7.json")
		do {
			let success = try url?.checkResourceIsReachable()
			guard success == true else {
				print ("Could not check for new recipes")
				return
			}
		} catch let error
		{
			print(error.localizedDescription)
		}
		let task = URLSession.shared.dataTask(with: url!) {(data, response, error) in
			guard error == nil else {
				//print(error?.localizedDescription)
				print ("Could not load new recipes")
				return
			}
						if let content = data {
				do {
					let myJson = try JSONSerialization.jsonObject(with: content, options: JSONSerialization.ReadingOptions.mutableContainers) as AnyObject
					print (myJson)
					if let recipes = myJson["recipes"] as? NSDictionary
					{
						print(recipes)
						print(recipes["Tortillas"].debugDescription)
					}
				} catch let error
				{
					print(error.localizedDescription)
				}
			}
		}
		task.resume()
	}
    
    private static func readCSVFile() -> String? {
        var fullText: String?
        let path = Bundle.main.path(forResource: "recipes", ofType: "csv")
        do {
            //reading
            fullText = try String(contentsOfFile: path!, encoding: String.Encoding.utf8)
        }
        catch {/* error handling*/
            print("error occured while reading from csv-file")
            print(error.localizedDescription)
        }
        return fullText
    }
	
	private static func importRecipies() {
        let context = AppDelegate.viewContext
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
				
				let recipe = Recipe(context: context)
				recipe.name = recipeName
				recipe.ingredients = recipeIngredients
				recipe.instruction = recipeInstruction
				if recipeImage != nil {
					print("Now saving image to core data")
					recipe.image = recipeImage
				}
				try? context.save()
			}
		}
	}
}

