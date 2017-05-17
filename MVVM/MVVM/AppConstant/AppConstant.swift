//
//  AppConstant.swift
//  MVVM
//
//  Created by Mustafa Ezzat on 5/7/17.
//  Copyright © 2017 Mustafa Ezzat. All rights reserved.
//


enum AppConstant{
    enum CellIdentifier{
        static let Country = "CountryCell"
        static let City = "CityCell"
        static let SuperMarket = "SuperMarketCell"
        static let Category = "CategoryCell"
        static let Product = "ProductCell"
        static let Cart = "CartCell"
    }
    enum Colors{
        static let Blue     = "#0ab3d4"
        static let Yellow   = "#ffba00"
        static let Red      = "#e3001d"
        static let Green    = "#00aa5c"
    }
    
    enum Images {
        static let Checked     = "check"
        static let Unchecked     = "uncheck"
        static let PlaceHolderFlag     = "uncheck"
    }
    enum TabBar{
        static let count = 3
    }
    enum ViewControllerIdentifier{
        static let Country = "CountryViewController"
        static let SuperMarket = "SuperMarketViewController"
        static let Category = "CategoryViewController"
        static let Product = "ProductViewController"
        static let TabBar = "TabBarController"
    }
    enum Segues{
        static let Store = "storeSegue"
        static let Category = "categorySegue"
        static let Product = "productSegue"
        static let Country = "countrySegue"
        static let Go = "goSegue"
    }
    enum UserDefaultsIdentifier {
        static let City = "cityID"
        static let Country = "countryID"
        static let Currency = "Currency"
        static let APPLE_LANGUAGE_KEY = "AppleLanguages"
    }
    enum Notifications{
        static let NSProductCount = "NSProductCount"
        static let NSProductPrice = "NSProductPrice"
        static let NSDummyUpdate = "NSDummyUpdate"
        static let NSPureUpdate = "NSPureUpdate"
    }
    enum Localize{
        static let TotalPrice = "TotalPrice"
    }
}
