//
//  SuperMarket.swift
//  MagadiHome
//
//  Created by Mustafa Ezzat on 5/9/17.
//  Copyright © 2017 Waqood. All rights reserved.
//

import Foundation

class CategoryViewModel: NSObject {
    private var category:CategoryModel?
    var categoryID: Int {
        return category!.categoryID!
    }
    var name: String {
        return category!.name!
    }
    var image: String {
        return category!.image!
    }
    init(category: CategoryModel) {
        self.category = category
    }
}
