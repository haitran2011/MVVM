//
//  CategoryModel.swift
//  MVVM
//
//  Created by Mustafa Ezzat on 5/9/17.
//  Copyright © 2017 Mustafa Ezzat. All rights reserved.
//

import Foundation
import ObjectMapper

class CategoryModel: Mappable {
    var categoryID: Int?
    var name: String?
    var image: String?
    
    init?(){
    }
    
    required init?(map: Map){
    }
    
    func mapping(map: Map) {
        categoryID <- map["id"]
        name <- map["name"]
        image <- map["image"]
    }
}
