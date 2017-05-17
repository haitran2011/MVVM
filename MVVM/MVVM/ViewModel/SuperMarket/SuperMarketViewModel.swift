//
//  SuperMarket.swift
//  MagadiHome
//
//  Created by Mustafa Ezzat on 5/9/17.
//  Copyright © 2017 Waqood. All rights reserved.
//

import Foundation

class SuperMarketViewModel: NSObject {
    private var superMarket:SuperMarketModel?
    var superMarketID: Int {
        return superMarket!.superMarketID!
    }
    var name_en: String {
        return superMarket!.name_en!
    }
    var name_ar: String {
        return superMarket!.name_ar!
    }
    var logo: String {
        return superMarket!.logo!
    }
    init(superMarket: SuperMarketModel) {
        self.superMarket = superMarket
    }
}
