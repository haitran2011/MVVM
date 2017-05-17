//
//  SuperMarketViewController.swift
//  MagadiHome
//
//  Created by Mustafa Ezzat on 5/8/17.
//  Copyright © 2017 Waqood. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class SuperMarketViewController: BaseViewController {
    @IBOutlet weak var superMarketTable: UITableView!
    var superMarketListViewModel:SuperMarketListViewModel!
    var disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        superMarketTable.register(UINib(nibName: AppConstant.CellIdentifier.SuperMarket, bundle: nil), forCellReuseIdentifier: AppConstant.CellIdentifier.SuperMarket)
        
        let cityID = UserDefaults.standard.value(forKey: AppConstant.UserDefaultsIdentifier.City) as! Int
        let countryID = UserDefaults.standard.value(forKey: AppConstant.UserDefaultsIdentifier.Country) as! Int
        
        superMarketListViewModel = SuperMarketListViewModel(in: countryID, cityID: cityID)
        
        populateListTableView()
        setupCellWhenTapped()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    // MARK: - perform a binding from observableCity from ViewModel to TableView
    private func populateListTableView() {
        let observableTodos = superMarketListViewModel.getSuperMarkets().asObservable()
        observableTodos.bindTo(superMarketTable.rx.items(cellIdentifier: AppConstant.CellIdentifier.SuperMarket, cellType: SuperMarketCell.self)) { (row, element, cell) in
            cell.configure(with: element)
            }
            .addDisposableTo(disposeBag)
    }
    // MARK: - subscribe to TableView when item has been selected
    private func setupCellWhenTapped() {
        superMarketTable.rx.itemSelected
            .subscribe(onNext: { indexPath in
                //viewCategoryAction
                self.viewCategoryAction(index: indexPath.row)
            })
            .addDisposableTo(disposeBag)
    }

    func viewCategoryAction(index:Int){
        let superMarketModelView = superMarketListViewModel.getSuperMarkets().value[index]
        SharedManager.sharedInstance.superMarketID = superMarketModelView.superMarketID
        performSegue(withIdentifier: AppConstant.Segues.Category, sender: self)
    }

}
