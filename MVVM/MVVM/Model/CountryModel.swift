//
//  CountryModel.swift
//  MagadiHome
//
//  Created by Mustafa Ezzat on 5/6/17.
//  Copyright © 2017 Waqood. All rights reserved.
//

import Foundation
import ObjectMapper

class CountryModel: Mappable {
    var countryID: Int?
    var name_en: String?
    var name_ar: String?
    var name_short: String?
    var currency_name_en: String?
    var currency_name_ar: String?
    var currency_symbol_en: String?
    var currency_symbol_ar: String?
    var flag: String?
    var cities:Array<CityModel> = Array<CityModel>()
    
    required init?(map: Map){
    }
    
    func mapping(map: Map) {
        countryID <- map["id"]
        name_en <- map["name_en"]
        name_ar <- map["name_ar"]
        name_short <- map["name_short"]
        currency_name_en <- map["currency_name_en"]
        currency_name_ar <- map["currency_name_ar"]
        currency_symbol_en <- map["currency_symbol_en"]
        currency_symbol_ar <- map["currency_symbol_ar"]
        flag <- map["flag"]
        cities <- map["cities"]
    }
}
