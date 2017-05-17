//
//  CityListViewModel.swift
//  MagadiHome
//
//  Created by Mustafa Ezzat on 5/7/17.
//  Copyright © 2017 Waqood. All rights reserved.
//

import Foundation
import RxSwift

class CityListViewModel:NSObject {
    private var cities = Variable<[CityViewModel]>([])
    private var disposeBag = DisposeBag()
    override init() {
        super.init()
        fetchObservableData()
    }
    // MARK: - return observable countries
    private func fetchObservableData(){
        cities.asObservable()
            .map({ $0 })
            .subscribe(onNext : { (event) in
            })
            .addDisposableTo(disposeBag)
    }
    public func getCities() -> Variable<[CityViewModel]> {
        return cities
    }
    // MARK: - toggle selected city's isChecked value
    public func toggleIsChecked(withIndex index: Int) {
        unCheckAll()
        cities.value[index].isChecked = !cities.value[index].isChecked
        cities.value.append(contentsOf: [])
    }
    func unCheckAll(){
        for item in cities.value {
            item.isChecked = false
        }
    }
    
    func setCities(cityModels: Array<CityModel>) {
        var cityViewModels = Array<CityViewModel>()
        for item in cityModels {
            let cityViewModel = CityViewModel(city: item)
            cityViewModel.isChecked = false
            cityViewModels.append(cityViewModel)
        }
        cities.value.removeAll()
        cities.value.append(contentsOf: cityViewModels)
    }
}
