//
//  Recipe.swift
//  Mampf
//
//  Created by Fabian Braig on 16.08.17.
//  Copyright © 2017 Fabian Braig. All rights reserved.
//

import Foundation

struct Recipe : CustomStringConvertible
{
    let name: String?
    let ingredients: String?
    let instruction: String?
    
    var description: String {
        return "Recipe"
            + ((name != nil) ? name! : "")
            + ((ingredients != nil) ? ingredients! : "")
            + ((instruction != nil) ? instruction! : "")
    }
}
