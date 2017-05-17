//
//  SuperMarketListViewModel.swift
//  MVVM
//
//  Created by Mustafa Ezzat on 5/9/17.
//  Copyright © 2017 Mustafa Ezzat. All rights reserved.
//

import Foundation
import RxSwift

class SuperMarketListViewModel:NSObject, APIDelegate {
    private var superMarkets = Variable<[SuperMarketViewModel]>([])
    private var disposeBag = DisposeBag()
    init(in countryID:Int, cityID:Int) {
        super.init()
        fetchObservableData(in: countryID, cityID: cityID)
    }
    // MARK: - return observable supermarkets
    private func fetchObservableData(in countryID:Int, cityID:Int){
        superMarkets.asObservable()
            .map({ $0 })
            .subscribe(onNext : { (event) in
            })
            .addDisposableTo(disposeBag)
        APIManager.sharedInstance.fetchSuperMarkets(in: countryID, cityID: cityID, delegate: self)
    }
    public func getSuperMarkets() -> Variable<[SuperMarketViewModel]> {
        return superMarkets
    }
    
    func requestDidStart() {
        print("Start....")
    }
    func requestDidEnd(payload: AnyObject) {
        let superMarketModels = payload as! Array<SuperMarketModel>
        var superMarketViewModels = Array<SuperMarketViewModel>()
        for item in superMarketModels {
            let superMarketViewModel = SuperMarketViewModel(superMarket: item)
            superMarketViewModels.append(superMarketViewModel)
        }
        superMarkets.value.append(contentsOf: superMarketViewModels)
    }
    func requestDidEnd(with error: String) {
        print(error)
    }
}
