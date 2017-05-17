//
//  TabBarController.swift
//  Nashr
//
//  Created by Mustafa Ezzat on 2/26/17.
//  Copyright © 2017 waqood. All rights reserved.
//

import UIKit
import QuartzCore

class TabBarController: UITabBarController, UITabBarControllerDelegate {
    private var productDataAccessProvider = ProductDataAccessProvider()
    var previousController = UIViewController()
    let cartView = UIView(frame: CGRect(x: 0, y: 0, width: 24, height: 24))
    let cartLable = UILabel(frame: CGRect(x: 0, y: 0, width: 24, height: 24))
    var cartCount = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        NotificationCenter.default.addObserver(self, selector: #selector(refreshCount(_:)), name: NSNotification.Name(rawValue: AppConstant.Notifications.NSProductCount), object: nil)
        
        tabBarSettings()
        
        //update currency
        SharedManager.sharedInstance.currency = UserDefaults.standard.value(forKey: AppConstant.UserDefaultsIdentifier.Currency) as! String
        
        addCartView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func viewController(at index:Int) -> UIViewController {
        return self.viewControllers![index]
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    func tabBarSettings(){
        selectedIndex = AppConstant.TabBar.count
        previousController = viewController(at: selectedIndex)
        delegate = self
        
        if let items = self.tabBar.items {
            for item in items {
                if let image = item.image {
                    item.image = image.withRenderingMode( .alwaysOriginal )
                }
            }
        }
    }

    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        if previousController == viewController{
            if viewController.responds(to: #selector(scrollToTop)){
                viewController.scrollToTop()            }
        }
        
        previousController = viewController
    }
    
    // MARK: - Setups
    
    func addCartView() {
        addView(add: cartView, in: view, x: view.bounds.width/4 + 40  , y: view.bounds.height - 48)
        addView(add: cartLable, in: cartView, x: 0, y: 0)
        updateCart()
        cartLable.textColor = UIColor.white
        cartLable.textAlignment = NSTextAlignment.center
        
    }
    
    func addView(add subView:UIView, in parentView:UIView, x:CGFloat, y:CGFloat){
        var frame = subView.frame
        frame.origin.x = x
        frame.origin.y = y
        subView.frame = frame
        subView.backgroundColor = UIColor.red
        subView.layer.cornerRadius = frame.height/2
        subView.layer.masksToBounds = true
        parentView.addSubview(subView)
        parentView.layoutIfNeeded()
    }
    func refreshCount(_ notification: NSNotification){
        let count = notification.object as? Int
        cartCount = cartCount + count!
        cartLableText(count:cartCount)
    }
    // MARK: - fetch data from CoreData cart
    func updateCart(){
        var count = 0
        var price:Double = 0.0
            for product in productDataAccessProvider.fetchData(){
                    count += product.productCount
                    price += product.productPrice * Double(product.productCount)
            }
        cartCount = count
        cartLableText(count:cartCount)
    }
    func cartLableText(count:Int){
        if count == 0{
            cartView.isHidden = true
        }
        else if count > 99{
            cartLable.text = "+99"
            cartLable.font = UIFont.boldSystemFont(ofSize: 10)
            cartView.isHidden = false
        }
        else{
            cartLable.text = "\(SharedManager.sharedInstance.englishToArabicNumber(enNumber: "\(count)"))"
            
            cartLable.font = UIFont.boldSystemFont(ofSize: 12)
            cartView.isHidden = false
        }
    }
}

