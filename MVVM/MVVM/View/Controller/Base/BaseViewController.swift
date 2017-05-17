//
//  BaseViewController.swift
//  MagadiHome
//
//  Created by Mustafa Ezzat on 5/8/17.
//  Copyright © 2017 Waqood. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController, UIGestureRecognizerDelegate {
    @IBOutlet weak var pageTitle: UINavigationItem!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        handleArabicApp()
        
        self.navigationController?.navigationBar.titleTextAttributes =
            [NSForegroundColorAttributeName: UIColor.black,
             NSFontAttributeName: UIFont(name: "NeoSansW23-Medium", size: 24)!]
        
        if let _img = self.navigationItem.leftBarButtonItem?.image {
            self.navigationItem.leftBarButtonItem?.image = UIImage(cgImage: _img.cgImage!, scale:_img.scale , orientation: UIImageOrientation.upMirrored)
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        AppUtility.lockOrientation(.portrait, andRotateTo: .portrait)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        AppUtility.lockOrientation(.all)
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
    
    func handleArabicApp() {
        self.navigationController?.interactivePopGestureRecognizer?.delegate = self;
        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = true
        
        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(swiped(_:)))
        swipeLeft.direction = .left
        self.view.addGestureRecognizer(swipeLeft)
    }

    func swiped(_ gesture: UIGestureRecognizer){
        backAction(self)
    }
    
    @IBAction func backAction(_ sender: Any) {
        _ = navigationController?.popViewController(animated: true)
    }
    
}
