//
//  Recipe.swift
//  Mampf
//
//  Created by Fabian Braig on 16.08.17.
//  Copyright © 2017 Fabian Braig. All rights reserved.
//

import UIKit
import CoreData

class Recipe : NSManagedObject
{
	var image: UIImage? {
		get {
			var tempImage: UIImage?
			if imageData != nil {
				tempImage = UIImage(data: imageData! as Data)
			}
			return tempImage
		}
		set(newImage) {
			if newImage != nil {
				imageData = UIImagePNGRepresentation(newImage!)! as NSData
			}
		}
	}
}
