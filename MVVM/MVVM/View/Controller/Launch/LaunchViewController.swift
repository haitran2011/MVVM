//
//  LaunchViewController.swift
//  MVVM
//
//  Created by Mustafa Ezzat on 5/16/17.
//  Copyright © 2017 Mustafa Ezzat. All rights reserved.
//

import UIKit

class LaunchViewController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.navigationController?.isNavigationBarHidden = true
        whichSeguesWillPerform()
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
    func whichSeguesWillPerform(){
        if SharedManager.sharedInstance.isKeyPresentInUserDefaults(key: AppConstant.UserDefaultsIdentifier.Country){
            performSegue(withIdentifier: AppConstant.Segues.Go, sender: self)
        }
        else{
            performSegue(withIdentifier: AppConstant.Segues.Country, sender: self)
        }
    }
}
