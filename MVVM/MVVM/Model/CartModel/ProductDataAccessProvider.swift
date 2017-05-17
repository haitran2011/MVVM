//
//  ProductDataAccessProvider.swift
//  MVVM
//
//  Created by Mustafa Ezzat on 5/10/17.
//  Copyright © 2017 Mustafa Ezzat. All rights reserved.
//


import Foundation
import CoreData
import RxSwift

class ProductDataAccessProvider {
    
    private var productsFromCoreData = Variable<[Product]>([])
    private var managedObjectContext : NSManagedObjectContext
    
    init() {
        let delegate = UIApplication.shared.delegate as! AppDelegate
        productsFromCoreData.value = [Product]()
        managedObjectContext = delegate.persistentContainer.viewContext
        productsFromCoreData.value = fetchData()
    }
    
    // MARK: - fetching Products from Core Data and update observable Products
    public func fetchData() -> [Product] {
        let productFetchRequest = Product.productFetchRequest()
        productFetchRequest.returnsObjectsAsFaults = false
        
        do {
            return try managedObjectContext.fetch(productFetchRequest)
        } catch {
            return []
        }
        
    }
    // MARK: - return observable Product
    public func fetchObservableData() -> Observable<[Product]> {
        productsFromCoreData.value = fetchData()
        return productsFromCoreData.asObservable()
    }
    
    // MARK: - add new Product from Core Data
    public func addProduct(from productViewModel:ProductViewModel) {
        let index = isProductExist(with: productViewModel.productID)
        if index != -1{
            updateCount(at: index, value: 1)
            return
        }
        
        let product = NSEntityDescription.insertNewObject(forEntityName: "Product", into: managedObjectContext) as! Product
        product.productID = productViewModel.productID
        product.productCount = productViewModel.count
        product.companyName = productViewModel.category_name
        product.productSize = productViewModel.size_ar
        product.productName = productViewModel.name_ar
        product.productPrice = productViewModel.price
        update()
    }
    // MARK: - sub Product count from Core Data
    public func subProduct(from productViewModel:ProductViewModel) {
        let index = isProductExist(with: productViewModel.productID)
        if index != -1{
            updateCount(at: index, value: -1)
            return
        }
    }
    // MARK: - update Product count from Core Data
    public func updateCount(at indext:Int, value:Int){
        let count = productsFromCoreData.value[indext].productCount
        let newCount = count + value
        if newCount == 0{
            removeProduct(withIndex: indext)
        }
        else{
            productsFromCoreData.value[indext].productCount = newCount
            update()
        }
    }
    // MARK: - selected Product
    public func isProductExist(with productID:Int) -> Int{
        var index = -1
        for i in 0 ..< productsFromCoreData.value.count{
            if productsFromCoreData.value[i].productID == productID{
                index = i
                break
            }
        }
        return index
    }

    // MARK: - remove specified Product from Core Data
    public func removeProduct(withIndex index: Int) {
        managedObjectContext.delete(productsFromCoreData.value[index])
        update()
    }
    
    private func update(){
        do {
            try managedObjectContext.save()
            productsFromCoreData.value = fetchData()
        } catch {
            fatalError("error change data")
        }
    }
    
}
