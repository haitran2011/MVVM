//
//  APIMarkets.swift
//  MVVM
//
//  Created by Mustafa Ezzat on 5/8/17.
//  Copyright © 2017 Mustafa Ezzat. All rights reserved.
//

import Foundation
import Alamofire
import AlamofireObjectMapper
import ObjectMapper

class APIMarkets {
    static let sharedInstance: APIMarkets = {
        let instance = APIMarkets()
        // setup code
        return instance
    }()
    
    func fetchSuperMarkets(in countryID:Int, cityID:Int, delegate:APIDelegate) {
        delegate.requestDidStart()
        let url = "\(APIConstants.apiUrl)\(APIConstants.Methods.FetchSuperMarkets)/\(countryID)/\(cityID))"
        let headers:HTTPHeaders = ["tkn":APIConstants.token]
        Alamofire.request(url, headers: headers).responseArray {
            (response: DataResponse<Array<SuperMarketModel>>) in
            if let settingsResponse = response.result.value {
                //handle success
                delegate .requestDidEnd(payload: settingsResponse as AnyObject)
            }
        }
    }
    
    func fetchCategories(in superMarketID:Int, delegate:APIDelegate) {
        delegate.requestDidStart()
        let url = "\(APIConstants.apiUrl)\(APIConstants.Methods.FetchCategories)/\(superMarketID)"
        let headers:HTTPHeaders = ["tkn":APIConstants.token]
        Alamofire.request(url, headers: headers).responseArray {
            (response: DataResponse<Array<CategoryModel>>) in
            if let settingsResponse = response.result.value {
                //handle success
                delegate .requestDidEnd(payload: settingsResponse as AnyObject)
            }
        }
    }
    
    func fetchProducts(in categoryID:Int, superMarketID:Int, delegate:APIDelegate) {
        delegate.requestDidStart()
        let url = "\(APIConstants.apiUrl)\(APIConstants.Methods.FetchProducts)/\(categoryID)/\(superMarketID))"
        let headers:HTTPHeaders = ["tkn":APIConstants.token]
        Alamofire.request(url, headers: headers).responseArray {
            (response: DataResponse<Array<ProductModel>>) in
            if let settingsResponse = response.result.value {
                //handle success
                delegate .requestDidEnd(payload: settingsResponse as AnyObject)
            }
        }
    }
    
}
