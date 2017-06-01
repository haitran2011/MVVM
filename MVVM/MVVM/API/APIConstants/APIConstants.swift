//
//  APIConstants.swift
//  MVVM
//
//  Created by Mustafa Ezzat on 5/6/17.
//  Copyright © 2017 Mustafa Ezzat. All rights reserved.
//

enum APIConstants{
    enum Status {
        case fetchCountries
        case fetchSuperMarkets
        case fetchCategories
        case fetchProducts
    }
    enum Methods{
        static let FetchCountries = "Countries/getAllCountries"
        static let FetchSuperMarkets = "Supermarkets/getSupermarketsByCity"
        static let FetchCategories = "Supermarkets/getAllCatgories"
        static let FetchProducts = "Products/getProducts"
    }
    static let apiUrl = "http://www.your-base-url.com/"

    static let token = "eyJ0eXAiOiJKV1QiLCJhbGciOiJub25lIiwianRpIjoiNGYxZzIzYTEyYWEifQ.eyJqdGkiOiI0ZjFnMjNhMTJhYSIsImV4cCI6MTQ5Mzc2ODA4MSwiZXh0cmEiOnsiY2lkIjoiMSJ9fQ."
}
