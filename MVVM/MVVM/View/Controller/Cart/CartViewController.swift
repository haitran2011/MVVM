//
//  CartViewController.swift
//  MagadiHome
//
//  Created by Mustafa Ezzat on 5/12/17.
//  Copyright © 2017 Waqood. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class CartViewController: BaseViewController, ProductCellDelegate {
    @IBOutlet weak var cartTableView: UITableView!
    @IBOutlet weak var totalPrice: UILabel!
    
    let cartListViewModel:CartListViewModel = CartListViewModel()
    var disposeBag = DisposeBag()

    let notificationCenter:NotificationCenter = NotificationCenter()
    var price:Double = 0.0

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        notificationCenter.setObserver(self, selector: #selector(dummyUpdate(_:)), name: NSNotification.Name(rawValue: AppConstant.Notifications.NSDummyUpdate), object: nil)
        
        cartTableView.register(UINib(nibName: AppConstant.CellIdentifier.Cart, bundle: nil), forCellReuseIdentifier: AppConstant.CellIdentifier.Cart)
        
        populateListTableView()
        setupCellWhenTapped()
       
        price = cartListViewModel.getCartPrice()
        updatePrice(with: 0.0)
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
        let observableTodos = cartListViewModel.getCarts().asObservable()
        observableTodos.bindTo(cartTableView.rx.items(cellIdentifier: AppConstant.CellIdentifier.Cart, cellType: CartCell.self)) { (row, element, cell) in
                cell.configure(with: element, delegate: self, index: row)
            }
            .addDisposableTo(disposeBag)
    }
    // MARK: - subscribe to TableView when item has been selected
    private func setupCellWhenTapped() {
        cartTableView.rx.itemSelected
            .subscribe(onNext: { indexPath in
            })
            .addDisposableTo(disposeBag)
    }

    // MARK: - ProductCellDelegate
    func addProduct(index: Int) {
        updatePrice(with: cartListViewModel.getCarts().value[index].productPrice)
        cartListViewModel.addProduct(withIndex: index)
    }
    func subProduct(index: Int) {
        updatePrice(with: -1 * cartListViewModel.getCarts().value[index].productPrice)
        cartListViewModel.subProduct(withIndex: index)
    }
    
    func dummyUpdate(_ notification: NSNotification){
        let (sign, productPrice) = (notification.object as? (Int, Double))!
        updatePrice(with: Double(sign) * productPrice)
        cartListViewModel.dummyUpdate()
    }
    
    func updatePrice(with productPrice:Double){
        let sharedManager = SharedManager.sharedInstance
        price += productPrice
        totalPrice.text = "\(sharedManager.englishToArabicNumber(enNumber: "\(price)")) \(sharedManager.currency)"
    }

    
}
