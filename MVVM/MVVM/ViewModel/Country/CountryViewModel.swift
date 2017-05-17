//
//  CountryViewModel.swift
//  MagadiHome
//
//  Created by Mustafa Ezzat on 5/7/17.
//  Copyright © 2017 Waqood. All rights reserved.
//
import Foundation

class CountryViewModel: NSObject {
    private var county:CountryModel?
    var countryID: Int {
        return county!.countryID!
    }
    var name_en: String {
        return county!.name_en!
    }
    var name_ar: String {
        return county!.name_ar!
    }
    var name_short: String {
        return county!.name_short!
    }
    var currency_name_en: String {
        return county!.currency_name_en!
    }
    var currency_name_ar: String {
        return county!.currency_name_ar!
    }
    var currency_symbol_en: String {
        return county!.currency_symbol_en!
    }
    var currency_symbol_ar: String {
        return county!.currency_symbol_ar!
    }
    var flag: String {
        return county!.flag!
    }
    var isChecked: Bool = false

    var cities:Array<CityModel> {
        return (county?.cities)!
    }
    init(county: CountryModel) {
        self.county = county
    }
}
