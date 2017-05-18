//
//  CategoryListViewModel.swift
//  MVVM
//
//  Created by Mustafa Ezzat on 5/9/17.
//  Copyright © 2017 Mustafa Ezzat. All rights reserved.
//

import Foundation
import RxSwift

class ProductListViewModel:NSObject, APIDelegate {
    private var products = Variable<[ProductViewModel]>([])
    private var disposeBag = DisposeBag()
    private var productDataAccessProvider = ProductDataAccessProvider()

    init(in categoryID:Int, superMarketID:Int) {
        super.init()
        fetchObservableData(in: categoryID, superMarketID:superMarketID)
    }
    // MARK: - return observable categories
    private func fetchObservableData(in categoryID:Int, superMarketID:Int){
        products.asObservable()
            .map({ $0 })
            .subscribe(onNext : { (event) in
            })
            .addDisposableTo(disposeBag)
        APIManager.sharedInstance.fetchProducts(in: categoryID, superMarketID: superMarketID, companies: [], page:0, delegate: self)
    }

    public func getProducts() -> Variable<[ProductViewModel]> {
        return products
    }
    
    // MARK: - add Product
    public func addProduct(withIndex index: Int) {
        shareProductCount(count: 1)
        shareProductPrice(price: products.value[index].price)
        
        products.value[index].count += 1
        products.value.append(contentsOf: [])
        productDataAccessProvider.addProduct(from: products.value[index])
        dummyUpdate(sign: 1, price: products.value[index].price)

    }
    public func subProduct(withIndex index: Int) -> Bool {
        if products.value[index].count == 0{
            dummyUpdate(sign: 0, price: products.value[index].price)
            return false
        }
        shareProductCount(count: -1)
        shareProductPrice(price: -1 * products.value[index].price)
        
        products.value[index].count -= 1
        products.value.append(contentsOf: [])
        productDataAccessProvider.subProduct(from: products.value[index])
        dummyUpdate(sign: -1, price: products.value[index].price)
        
        return true
    }
    func shareProductCount(count:Int){
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: AppConstant.Notifications.NSProductCount), object:count)
    }
    // MARK: - share total Price
    func shareProductPrice(price:Double){
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: AppConstant.Notifications.NSProductPrice), object:price)
    }
    func dummyUpdate(sign:Int, price:Double){
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: AppConstant.Notifications.NSDummyUpdate), object:(sign, price))
    }
    // MARK: - fetch data from CoreData cart
    func updateProductCount(productList:Array<ProductViewModel>){
        for productViewModel in productList {
            for product in productDataAccessProvider.fetchData(){
                if productViewModel.productID == product.productID{
                    productViewModel.count = product.productCount
                    break
                }
            }
        }
    }
    func getCartPrice() -> Double {
        var price:Double = 0.0
        for product in productDataAccessProvider.fetchData(){
            price += product.productPrice * Double(product.productCount)
        }
        return price
    }
    public func pureUpdate(productID:Int, value:Int){
        for product in products.value {
            if product.productID == productID{
                product.count += value
                break
            }
        }
        products.value.append(contentsOf: [])
    }
    
    // MARK: - APIDelegate
    func requestDidStart() {
        print("Start....")
    }
    func requestDidEnd(payload: AnyObject) {
        let productModels = payload as! Array<ProductModel>
        var productViewModels = Array<ProductViewModel>()
        for item in productModels {
            let productViewModel = ProductViewModel(product: item)
            productViewModels.append(productViewModel)
        }
        //update from coreData cart
        updateProductCount(productList: productViewModels)
        //append to products
        products.value.append(contentsOf: productViewModels)
    }
    func requestDidEnd(with error: String) {
        print(error)
    }
}
