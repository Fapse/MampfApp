//
//  JsonRecipeLoader.swift
//  Mampf
//
//  Created by Fabian Braig on 06.10.17.
//  Copyright © 2017 Fabian Braig. All rights reserved.
//

import Foundation
struct JsonRecipeLoader {
	static let url = URL(string: "file:///Volumes/Public/Mampf/recipes7.json")
	
	static func loadJsonRecipes() {
		let request = URLRequest(url: url!)
		let task = URLSession.shared.dataTask(with: request) { (data:Data?, response:URLResponse?, error:Error?) in
			if let data = data {
				do {
					if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String:Any] {
						if let recipes = json["recipes"] as? [String:Any] {
							//print(recipes)
							for recipe in recipes {
								print(recipe.key)
								print(recipe.value)
							}
						}
					}
				} catch {
					print (error.localizedDescription)
				}
			}
		}
		task.resume()
	}
}
