//
//  CountryListViewModel.swift
//  MagadiHome
//
//  Created by Mustafa Ezzat on 5/7/17.
//  Copyright © 2017 Waqood. All rights reserved.
//

import Foundation
import RxSwift

class CountryListViewModel:NSObject, APIDelegate {
    private var countries = Variable<[CountryViewModel]>([])
    private var disposeBag = DisposeBag()
    override init() {
        super.init()
        fetchObservableData()
    }
    // MARK: - return observable countries
    private func fetchObservableData(){
        
        countries.asObservable()
            .map({ $0 })
            .subscribe(onNext : { (event) in
            })
            .addDisposableTo(disposeBag)
        
        APIManager.sharedInstance.fetchCountries(delegate: self)
    }
    public func getCountries() -> Variable<[CountryViewModel]> {
        return countries
    }
    // MARK: - toggle selected country's isChecked value
    public func toggleIsChecked(withIndex index: Int) {
        unCheckAll()
        countries.value[index].isChecked = !countries.value[index].isChecked
        countries.value.append(contentsOf: [])
    }
    func unCheckAll(){
        for item in countries.value {
            item.isChecked = false
        }
    }
    func requestDidStart() {
        print("Start....")
    }
    func requestDidEnd(payload: AnyObject) {
        let countryModels = payload as! Array<CountryModel>
        var countryViewModels = Array<CountryViewModel>()
        for item in countryModels {
            let countryViewModel = CountryViewModel(county: item)
            countryViewModel.isChecked = false
            countryViewModels.append(countryViewModel)
        }
        countries.value.append(contentsOf: countryViewModels)
    }
    func requestDidEnd(with error: String) {
        print(error)
    }
}
