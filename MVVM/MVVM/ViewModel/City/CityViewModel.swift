//
//  CountryViewModel.swift
//  MVVM
//
//  Created by Mustafa Ezzat on 5/7/17.
//  Copyright © 2017 Mustafa Ezzat. All rights reserved.
//
import Foundation

class CityViewModel: NSObject {
    private var city:CityModel?
   
    var cityID: Int {
        return city!.cityID!
    }
    var name_en: String {
        return city!.name_en!
    }
    var name_ar: String {
        return city!.name_ar!
    }
    var isChecked: Bool = false

    
    init(city: CityModel) {
        self.city = city
    }
}
