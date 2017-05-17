//
//  CartListViewModel.swift
//  MagadiHome
//
//  Created by Mustafa Ezzat on 5/11/17.
//  Copyright © 2017 Waqood. All rights reserved.
//

import Foundation
import RxSwift
import CoreData

struct CartListViewModel {
    private var carts = Variable<[Product]>([])
    private var productDataAccessProvider = ProductDataAccessProvider()
    private var disposeBag = DisposeBag()
    
    init() {
        fetchcartsAndUpdateObservablecarts()
    }
    
    public func getCarts() -> Variable<[Product]> {
        return carts
    }
    
    // MARK: - fetching carts from Core Data and update observable carts
    private func fetchcartsAndUpdateObservablecarts() {
        productDataAccessProvider.fetchObservableData()
            .map({ $0 })
            .subscribe(onNext : { (carts) in
                self.carts.value = carts
            })
            .addDisposableTo(disposeBag)
    }
    // MARK: - add Product
    public func addProduct(withIndex index: Int) {
        pureUpdate(productID:carts.value[index].productID, value: 1, productPrice:carts.value[index].productPrice)
        shareProductCount(count: 1)
        productDataAccessProvider.updateCount(at: index, value: 1)
    }
    public func subProduct(withIndex index: Int) {
        if carts.value[index].productCount == 0{
           return
        }
        pureUpdate(productID:carts.value[index].productID, value: -1, productPrice:carts.value[index].productPrice)
        shareProductCount(count: -1)
        productDataAccessProvider.updateCount(at: index, value: -1)
    }
    func getCartPrice() -> Double {
        var price:Double = 0.0
        for product in productDataAccessProvider.fetchData(){
            price += product.productPrice * Double(product.productCount)
        }
        return price
    }
    func pureUpdate(productID:Int, value:Int, productPrice:Double){
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: AppConstant.Notifications.NSPureUpdate), object:(productID, value, productPrice))
    }
    public func dummyUpdate() {
        fetchcartsAndUpdateObservablecarts()
    }
    
    func shareProductCount(count:Int){
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: AppConstant.Notifications.NSProductCount), object:count)
    }
}
