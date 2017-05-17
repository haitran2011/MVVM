//
//  APILocations.swift
//  MVVM
//
//  Created by Mustafa Ezzat on 5/6/17.
//  Copyright © 2017 Mustafa Ezzat. All rights reserved.
//

import Foundation
import Alamofire
import AlamofireObjectMapper
import ObjectMapper

class APILocations {
    static let sharedInstance: APILocations = {
        let instance = APILocations()
        // setup code
        return instance
    }()
    
    func fetchCountries(delegate:APIDelegate) {
        delegate.requestDidStart()
        let url = "\(APIConstants.apiUrl)\(APIConstants.Methods.FetchCountries)"
        let headers:HTTPHeaders = ["tkn":APIConstants.token]
        Alamofire.request(url, headers: headers).responseArray {
            (response: DataResponse<Array<CountryModel>>) in
            if let settingsResponse = response.result.value {
                //handle success
                delegate .requestDidEnd(payload: settingsResponse as AnyObject)
            }
        }

    }
}
