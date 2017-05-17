//
//  ViewController.swift
//  MagadiHome
//
//  Created by Mustafa Ezzat on 5/6/17.
//  Copyright © 2017 Waqood. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class CountryViewController: BaseViewController, UICollectionViewDelegateFlowLayout {
    @IBOutlet weak var countriesCollectionView: UICollectionView!
    @IBOutlet weak var citiesTableView: UITableView!
    @IBOutlet weak var nextButton: UIButton!
    
    var cityID:Int = -1
    var countryID:Int = -1
    var currency:String = ""
    
    
    var countryListViewModel = CountryListViewModel()
    var cityListViewModel = CityListViewModel()
    var disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        countriesCollectionView.register(UINib(nibName: AppConstant.CellIdentifier.Country, bundle: nil), forCellWithReuseIdentifier: AppConstant.CellIdentifier.Country)
        citiesTableView.register(UINib(nibName: AppConstant.CellIdentifier.City, bundle: nil), forCellReuseIdentifier: AppConstant.CellIdentifier.City)
        
        self.navigationController?.isNavigationBarHidden = false

        populateListCollectionView()
        setupCountryWhenTapped()
        
        populateListTableView()
        setupCityWhenTapped()
    }
    // MARK: - perform a binding from observableCountry from ViewModel to countriesCollectionView
    private func populateListCollectionView() {
        let observableTodos = countryListViewModel.getCountries().asObservable()
        observableTodos.bindTo(countriesCollectionView.rx.items(cellIdentifier: AppConstant.CellIdentifier.Country, cellType: CountryCell.self)) { (row, element, cell) in
                cell.configure(with: element)
            }
            .addDisposableTo(disposeBag)
        // add this line you can provide the cell size from delegate method
        //countriesCollectionView.rx.setDelegate(self).addDisposableTo(disposeBag)
    }
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cellWidth = (countriesCollectionView.frame.size.width - 24.0)/3.0
        print("cellWidth: \(cellWidth)")
        return CGSize(width: cellWidth, height: 120.0)
    }
    // MARK: - perform a binding from observableCity from ViewModel to citiesTableView
    private func populateListTableView() {
        let observableTodos = cityListViewModel.getCities().asObservable()
        observableTodos.bindTo(citiesTableView.rx.items(cellIdentifier: AppConstant.CellIdentifier.City, cellType: CityCell.self)) { (row, element, cell) in
                cell.configure(with: element)
            }
            .addDisposableTo(disposeBag)
    }
    // MARK: - subscribe to countriesCollectionView when item has been selected
    private func setupCountryWhenTapped() {
        countriesCollectionView.rx.itemSelected
            .subscribe(onNext: { indexPath in
                self.countriesCollectionView.deselectItem(at: indexPath, animated: false)
                self.countryListViewModel.toggleIsChecked(withIndex: indexPath.row)
                //set Cities
                self.setPage(index: indexPath.row)
            })
            .addDisposableTo(disposeBag)
    }
    // MARK: - subscribe to citiesTableView when item has been selected
    private func setupCityWhenTapped() {
        citiesTableView.rx.itemSelected
            .subscribe(onNext: { indexPath in
                self.citiesTableView.deselectRow(at: indexPath, animated: false)
                self.cityListViewModel.toggleIsChecked(withIndex: indexPath.row)
                //setCityID
                self.setCiyID(index: indexPath.row)
            })
            .addDisposableTo(disposeBag)
    }
    func setPage(index:Int){
        //set cities
        let countryModelView = countryListViewModel.getCountries().value[index]
        if countryID == countryModelView.countryID{
            return
        }
        
        countryID = countryModelView.countryID
        currency = countryModelView.currency_symbol_ar
        
        cityListViewModel.setCities(cityModels: countryModelView.cities)
        
        //next button
        if countryModelView.cities.count > 0{
            nextButton.isEnabled = false
        }
        else{
            nextButton.isEnabled = true
        }
        //page title
        pageTitle.title = countryModelView.name_ar
    }
    func setCiyID(index:Int){
        let cityModelView = cityListViewModel.getCities().value[index]
        cityID = cityModelView.cityID
        nextButton.isEnabled = true
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func nextAction(_ sender: Any) {
        //navigate to supermarkets
        UserDefaults.standard.set(cityID, forKey: AppConstant.UserDefaultsIdentifier.City)
        UserDefaults.standard.set(countryID, forKey: AppConstant.UserDefaultsIdentifier.Country)
        UserDefaults.standard.set(currency, forKey: AppConstant.UserDefaultsIdentifier.Currency)
        performSegue(withIdentifier: AppConstant.Segues.Store, sender: self)
    }
    
}

