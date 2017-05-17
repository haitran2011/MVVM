//
//  APIManager.swift
//  MVVM
//
//  Created by Mustafa Ezzat on 5/6/17.
//  Copyright © 2017 Mustafa Ezzat. All rights reserved.
//

import Foundation
import Alamofire
import AlamofireImage

class APIManager {
    static let sharedInstance: APIManager = {
        let instance = APIManager()
        // setup code
        return instance
    }()
    // Mark: - 
    func fetchCountries(delegate:APIDelegate) {
        APILocations.sharedInstance.fetchCountries(delegate: delegate)
    }
    func fetchSuperMarkets(in countryID:Int, cityID:Int, delegate:APIDelegate) {
        APIMarkets.sharedInstance.fetchSuperMarkets(in: countryID, cityID: cityID, delegate: delegate)
    }
    func fetchCategories(in superMarketID:Int, delegate:APIDelegate) {
        APIMarkets.sharedInstance.fetchCategories(in: superMarketID, delegate: delegate)
    }
    func fetchProducts(in categoryID:Int, superMarketID:Int, delegate:APIDelegate) {
        APIMarkets.sharedInstance.fetchProducts(in: categoryID, superMarketID: superMarketID, delegate: delegate)
    }
    
    // MARK: - Lifecycle Methods
    func downloadImg(imgView:UIImageView, with URLString: String, placeholderImage: UIImage) {
        if URLString == ""{
            return
        }
        let urlStringEncoded = verifyUrl(urlString: URLString)
        let utilityQueue = DispatchQueue.global(qos: .utility)
        let size = imgView.frame.size
        imgView.af_setImage(
            withURL: URL(string: urlStringEncoded)!,
            placeholderImage: placeholderImage,
            filter: AspectScaledToFillSizeWithRoundedCornersFilter(size: size, radius: 0.0),
            progressQueue: utilityQueue,
            imageTransition: .crossDissolve(0.2)
        )
    }
    func verifyUrl (urlString: String?) -> String {
        //Check for nil
        if let urlString = urlString {
            // create NSURL instance
            if let _ = NSURL(string: urlString) {
                // check if your application can open the NSURL instance
                return urlString
            }
            else{
                return urlString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
            }
        }
        return ""
    }
}
