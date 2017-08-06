//
//  Cookbook.swift
//  Mampf
//
//  Created by Fabian Braig on 15.07.17.
//  Copyright © 2017 Fabian Braig. All rights reserved.
//

import Foundation

struct Cookbook {
    private var recipeDictionary = [String: [String]]()
    
    init() {
        recipeDictionary = readCSVFile()
    }
 
    func getRecipeInstructions(id: String) -> String {
        return recipeDictionary[id]![1]
    }
    func getRecipeIngredients(id: String) -> String {
        return recipeDictionary[id]![0]
    }
    
    func getRecipeList() -> [String] {
        return Array(recipeDictionary.keys.sorted())
    }
    
    private func readCSVFile() -> [String: [String]] {
        var fulltext = String()
        var recipeDict = [String: [String]]()
        let path = Bundle.main.path(forResource: "recipes", ofType: "csv")
        do {
            //reading
            fulltext = try String(contentsOfFile: path!, encoding: String.Encoding.utf8)
        }
        catch {/* error handling*/
            print("error occured")
            print(error.localizedDescription)
        }
        let delimeter = "\r\n"
        let newString: [String] = fulltext.components(separatedBy: delimeter)
        for i in 0..<newString.count
        {
            var recipeDescription: [String] = newString[i].components(separatedBy: ";")
            recipeDescription[1] = recipeDescription[1].replacingOccurrences(of: ",", with: "\n")
            recipeDescription[1] = recipeDescription[1].appending("\n\n")
            recipeDict[recipeDescription[0]] = [recipeDescription[1], recipeDescription[2]]
            //print(newString[i])
        }
        return recipeDict
    }
}
