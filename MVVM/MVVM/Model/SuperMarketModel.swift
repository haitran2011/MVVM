//
//  SuperMarketModel.swift
//  MagadiHome
//
//  Created by Mustafa Ezzat on 5/8/17.
//  Copyright © 2017 Waqood. All rights reserved.
//

//
//  CityModel.swift
//  MagadiHome
//
//  Created by Mustafa Ezzat on 5/6/17.
//  Copyright © 2017 Waqood. All rights reserved.
//

import Foundation
import ObjectMapper

class SuperMarketModel: Mappable {
    var superMarketID: Int?
    var name_en: String?
    var name_ar: String?
    var logo: String?
    
    init?(){
    }
    
    required init?(map: Map){
    }
    
    func mapping(map: Map) {
        superMarketID <- map["id"]
        name_en <- map["name_en"]
        name_ar <- map["name_ar"]
        logo <- map["logo"]
    }
}
