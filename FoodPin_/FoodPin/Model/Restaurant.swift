//
//  Restaurant.swift
//  FoodPin
//
//  Created by Simon Ng on 21/7/2016.
//  Copyright © 2016 AppCoda. All rights reserved.
//

import Foundation
import UIKit
class Restaurant {
    var name = ""
    var type = ""
    var location = ""
    var image = ""
    var isVisited = false
    var phone = ""
    var rating = ""
    var images: [UIImage]
    
    
    init(name: String, type: String, location: String, phone: String, image: String, isVisited: Bool, images: [UIImage] = []) {
        self.name = name
        self.type = type
        self.location = location
        self.phone = phone
        self.image = image
        self.isVisited = isVisited
        self.images = images
    }
}
