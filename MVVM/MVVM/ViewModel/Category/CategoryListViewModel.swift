//
//  CategoryListViewModel.swift
//  MagadiHome
//
//  Created by Mustafa Ezzat on 5/9/17.
//  Copyright © 2017 Waqood. All rights reserved.
//

import Foundation
import RxSwift

class CategoryListViewModel:NSObject, APIDelegate {
    private var categories = Variable<[CategoryViewModel]>([])
    private var disposeBag = DisposeBag()
    init(in superMarketID:Int) {
        super.init()
        fetchObservableData(in: superMarketID)
    }
    // MARK: - return observable categories
    private func fetchObservableData(in superMarketID:Int){
        categories.asObservable()
            .map({ $0 })
            .subscribe(onNext : { (event) in
            })
            .addDisposableTo(disposeBag)
        APIManager.sharedInstance.fetchCategories(in: superMarketID, delegate: self)
    }
    public func getCategories() -> Variable<[CategoryViewModel]> {
        return categories
    }
    
    func requestDidStart() {
        print("Start....")
    }
    func requestDidEnd(payload: AnyObject) {
        let categoryModels = payload as! Array<CategoryModel>
        var categoryViewModels = Array<CategoryViewModel>()
        for item in categoryModels {
            let categoryViewModel = CategoryViewModel(category: item)
            categoryViewModels.append(categoryViewModel)
        }
        categories.value.append(contentsOf: categoryViewModels)
    }
    func requestDidEnd(with error: String) {
        print(error)
    }
}
