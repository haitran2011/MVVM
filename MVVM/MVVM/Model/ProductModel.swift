//
//  ProductCategory.swift
//  MagadiHome
//
//  Created by Mustafa Ezzat on 5/10/17.
//  Copyright © 2017 Waqood. All rights reserved.
//

import Foundation
import ObjectMapper

class ProductModel: Mappable {
    var productID: Int?
    var name_en: String?
    var name_ar: String?
    var category_id: Int?
    var company_id: Int?
    var supermarket_id: Int?
    var price: Double?
    var size_ar: String?
    var size_en: String?
    var category_name: String?
    var company_name: String?
    var supermarket_name: String?
    var image: String?
    
    init?(){
    }
    
    required init?(map: Map){
    }
    
    func mapping(map: Map) {
        productID <- map["id"]
        name_en <- map["name_en"]
        name_ar <- map["name_ar"]
        category_id <- map["category_id"]
        company_id <- map["company_id"]
        supermarket_id <- map["supermarket_id"]
        price <- map["price"]
        size_ar <- map["size_ar"]
        size_en <- map["size_en"]
        category_name <- map["category_name"]
        company_name <- map["company_name"]
        supermarket_name <- map["supermarket_name"]
        image <- map["image"]
    }
}
