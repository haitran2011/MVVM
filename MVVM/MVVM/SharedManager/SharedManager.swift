//
//  SharedManager.swift
//  MVVM
//
//  Created by Mustafa Ezzat on 5/7/17.
//  Copyright © 2017 Mustafa Ezzat. All rights reserved.
//

import UIKit
import Foundation

class SharedManager {
    var superMarketID:Int!
    var categoryID:Int!
    var currency:String = ""
    
    static let sharedInstance: SharedManager = {
        let instance = SharedManager()
        // setup code
        return instance
    }()

    lazy var placeHolderFlag: UIImage = {
        let image = UIImage(named: AppConstant.Images.PlaceHolderFlag)!
        return image
    }()
    
    func getColor(with hexString:String) -> UIColor {
        return UIColor(hexString: hexString)
    }
    
    func englishToArabicNumber(enNumber:String) -> String {
        var arNumber = enNumber
        let numbers:Dictionary = ["0" : "٠","1" : "١", "2" : "٢", "3" : "٣", "4" : "٤", "5" : "٥", "6" : "٦", "7" : "٧", "8" : "٨", "9" : "٩"]
        for (key, value) in numbers {
            arNumber = arNumber.replacingOccurrences(of: key, with: value)
        }
        return arNumber
    }
    func isKeyPresentInUserDefaults(key: String) -> Bool {
        return UserDefaults.standard.object(forKey: key) != nil
    }
}
