//
//  CityModel.swift
//  MVVM
//
//  Created by Mustafa Ezzat on 5/6/17.
//  Copyright © 2017 Mustafa Ezzat. All rights reserved.
//

import Foundation
import ObjectMapper

class CityModel: Mappable {
    var cityID: Int?
    var name_en: String?
    var name_ar: String?
    
    init?(){
    }
    
    required init?(map: Map){
    }
    
    func mapping(map: Map) {
        cityID <- map["id"]
        name_en <- map["name_en"]
        name_ar <- map["name_ar"]
    }
}
