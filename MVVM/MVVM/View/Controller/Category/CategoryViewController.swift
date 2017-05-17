//
//  CategoryViewController.swift
//  MVVM
//
//  Created by Mustafa Ezzat on 5/8/17.
//  Copyright © 2017 Mustafa Ezzat. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class CategoryViewController: BaseViewController, UICollectionViewDelegateFlowLayout {
    @IBOutlet weak var categoryCollectionView: UICollectionView!
    
    var categoryListViewModel:CategoryListViewModel!
    var disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
       
        categoryListViewModel = CategoryListViewModel(in: SharedManager.sharedInstance.superMarketID)
        
        categoryCollectionView.register(UINib(nibName: AppConstant.CellIdentifier.Category, bundle: nil), forCellWithReuseIdentifier: AppConstant.CellIdentifier.Category)
        
        populateListCollectionView()
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
    // MARK: - perform a binding from observableCountry from ViewModel to countriesCollectionView
    private func populateListCollectionView() {
        let observableTodos = categoryListViewModel.getCategories().asObservable()
        observableTodos.bindTo(categoryCollectionView.rx.items(cellIdentifier: AppConstant.CellIdentifier.Category, cellType: CategoryCell.self)) { (row, element, cell) in
            cell.configure(with: element)
            }
            .addDisposableTo(disposeBag)
        // add this line you can provide the cell size from delegate method
        categoryCollectionView.rx.setDelegate(self).addDisposableTo(disposeBag)
    }
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cellWidth = (categoryCollectionView.frame.size.width-24.0)/3.0
        print("cellWidth: \(cellWidth)")
        return CGSize(width: cellWidth, height: cellWidth + 28.0)
    }
    // MARK: - subscribe to countriesCollectionView when item has been selected
    private func setupCellWhenTapped() {
        categoryCollectionView.rx.itemSelected
            .subscribe(onNext: { indexPath in
                //code here
                self.viewProductAction(index: indexPath.row)
            })
            .addDisposableTo(disposeBag)
    }
    
    func viewProductAction(index:Int){
        let categoryModelView = categoryListViewModel.getCategories().value[index]
        SharedManager.sharedInstance.categoryID = categoryModelView.categoryID
        performSegue(withIdentifier: AppConstant.Segues.Product, sender: self)
    }


}
