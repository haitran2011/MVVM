//
//  ProductViewController.swift
//  MagadiHome
//
//  Created by Mustafa Ezzat on 5/8/17.
//  Copyright © 2017 Waqood. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class ProductViewController: BaseViewController, ProductCellDelegate {
    @IBOutlet weak var productTableView: UITableView!
    @IBOutlet weak var totalPrice: UILabel!
    var productListViewModel:ProductListViewModel!
    var disposeBag = DisposeBag()
    let notificationCenter:NotificationCenter = NotificationCenter()
    var price:Double = 0.0

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        notificationCenter.setObserver(self, selector: #selector(pureUpdate(_:)), name: NSNotification.Name(rawValue: AppConstant.Notifications.NSPureUpdate), object: nil)
        
        productTableView.register(UINib(nibName: AppConstant.CellIdentifier.Product, bundle: nil), forCellReuseIdentifier: AppConstant.CellIdentifier.Product)
        
        let categoryID = SharedManager.sharedInstance.categoryID
        let superMarketID = SharedManager.sharedInstance.superMarketID
        
        productListViewModel = ProductListViewModel(in: categoryID!, superMarketID: superMarketID!)
        populateListTableView()
        setupCellWhenTapped()
        
        price = productListViewModel.getCartPrice()
        updatePrice(with: 0.0)
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
    }
    override func viewDidDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
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
        let observableTodos = productListViewModel.getProducts().asObservable()
        observableTodos.bindTo(productTableView.rx.items(cellIdentifier: AppConstant.CellIdentifier.Product, cellType: ProductCell.self)) { (row, element, cell) in
                cell.configure(with: element, delegate: self, index: row)
            }
            .addDisposableTo(disposeBag)
    }
    // MARK: - subscribe to TableView when item has been selected
    private func setupCellWhenTapped() {
        productTableView.rx.itemSelected
            .subscribe(onNext: { indexPath in
            })
            .addDisposableTo(disposeBag)
    }
    // MARK: - ProductCellDelegate
    func addProduct(index: Int) {
        updatePrice(with: productListViewModel.getProducts().value[index].price)
        productListViewModel.addProduct(withIndex: index)
    }
    func subProduct(index: Int) {
        //if in cart
        let exist = productListViewModel.subProduct(withIndex: index)
        if exist{
            updatePrice(with: -1 * productListViewModel.getProducts().value[index].price)
        }
    }
    
    func pureUpdate(_ notification: NSNotification){
        let (productID, value, productPrice) = (notification.object as? (Int, Int, Double))!
        updatePrice(with: Double(value) * productPrice)
        productListViewModel.pureUpdate(productID: productID, value: value)
    }
    
    func updatePrice(with productPrice:Double){
        let sharedManager = SharedManager.sharedInstance
        price += productPrice
        let totalText =  NSLocalizedString(AppConstant.Localize.TotalPrice, comment: "")
        totalPrice.text = "\(totalText): \(sharedManager.englishToArabicNumber(enNumber: "\(price)")) \(sharedManager.currency)"
    }

}
