//
//  SuperMarket.swift
//  MVVM
//
//  Created by Mustafa Ezzat on 5/9/17.
//  Copyright © 2017 Mustafa Ezzat. All rights reserved.
//

import Foundation

class ProductViewModel: NSObject {
    private var product:ProductModel?
    var productID: Int {
        return product!.productID!
    }
    var name_ar: String {
        return product!.name_ar!
    }
    var name_en: String {
        return product!.name_en!
    }
    var category_name: String {
        return product!.category_name!
    }
    var company_name: String {
        return product!.company_name!
    }
    var supermarket_name: String {
        return product!.supermarket_name!
    }
    var supermarket_id: Int {
        return product!.supermarket_id!
    }
    var category_id: Int {
        return product!.category_id!
    }
    var company_id: Int {
        return product!.company_id!
    }
    var size_en: String {
        return product!.size_en!
    }
    var size_ar: String {
        return product!.size_ar!
    }
    var price: Double {
        return product!.price!
    }
    var image: String {
        return product!.image!
    }
    
    var count:Int = 0
    
    init(product: ProductModel) {
        self.product = product
    }
}
