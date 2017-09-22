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

struct Cookbook {
	private let context = AppDelegate.viewContext
	
    init() {
		let request: NSFetchRequest<Recipe> = Recipe.fetchRequest()
		let sortDescriptor = NSSortDescriptor(key: "name", ascending: true)
		let predicate = NSPredicate(value: true)
		request.predicate = predicate
		request.sortDescriptors = [sortDescriptor]
		
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
		
		let counter2 = try? context.count(for: request)
		if let count = counter2 {
			print("Anzahl der Rezepte \(count)")
		} else {
			print("Probleme bei Kontrollabfrage")
		}
    }
    
    func getRecipe(id: String) -> Recipe? {
		let request: NSFetchRequest<Recipe> = Recipe.fetchRequest()
		let predicate = NSPredicate(format: "name = %@", id)
		request.predicate = predicate
		let tempRecipe = try? context.fetch(request).first!
		return tempRecipe
    }
    
    func getRecipeList(filterBy searchTerm: String? = nil) -> [String]? {
		let request: NSFetchRequest<Recipe> = Recipe.fetchRequest()
		let sortDescriptor = NSSortDescriptor(key: "name", ascending: true)
		var recipesArray = [String]()
		if searchTerm != nil && searchTerm != "" {
			request.predicate = NSPredicate(format: "ingredients contains[cd] %@", searchTerm!)
		} else {
			request.predicate = NSPredicate(value: true)
		}
		request.sortDescriptors = [sortDescriptor]
		
		let tempRecipes = try? context.fetch(request)

		for tempRecipe in tempRecipes! {
			recipesArray.append(tempRecipe.name!)
		}
		
		return recipesArray
    }

    private func readCSVFile() -> String? {
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
				
				let recipe = Recipe(context: context)
				recipe.name = recipeName
				recipe.ingredients = recipeIngredients
				recipe.instruction = recipeInstruction
				if recipeImage != nil {
					print("Now saving image to core data")
					recipe.image = recipeImage
				}
			}
		}
	}
}

