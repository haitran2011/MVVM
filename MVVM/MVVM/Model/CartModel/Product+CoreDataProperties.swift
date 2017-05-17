//
//  Cart+CoreDataProperties.swift
//  MagadiHome
//
//  Created by Mustafa Ezzat on 5/10/17.
//  Copyright © 2017 Waqood. All rights reserved.
//

import Foundation
import CoreData


extension Product {
    
    @nonobjc public class func productFetchRequest() -> NSFetchRequest<Product> {
        return NSFetchRequest<Product>(entityName: "Product");
    }
    
    @NSManaged public var productID: Int
    @NSManaged public var productCount: Int
    @NSManaged public var productName: String?
    @NSManaged public var productSize: String?
    @NSManaged public var productPrice: Double
    @NSManaged public var companyName: String?
    
}
