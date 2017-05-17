//
//  CartCell.swift
//  MagadiHome
//
//  Created by Mustafa Ezzat on 5/12/17.
//  Copyright © 2017 Waqood. All rights reserved.
//

import UIKit

class CartCell: UITableViewCell {
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var price: UILabel!
    @IBOutlet weak var company_name: UILabel!
    @IBOutlet weak var size: UILabel!
    @IBOutlet weak var count: UILabel!
    @IBOutlet weak var totalPrice: UILabel!
    
    var delegate:ProductCellDelegate!
    var index:Int!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func configure(with product:Product, delegate:ProductCellDelegate, index:Int) {
        name.text = product.productName
        price.text = "\(SharedManager.sharedInstance.englishToArabicNumber(enNumber: "\(product.productPrice)")) \(SharedManager.sharedInstance.currency)"
        size.text = product.productSize
        company_name.text = product.companyName
        count.text = "\(SharedManager.sharedInstance.englishToArabicNumber(enNumber: "\(product.productCount)"))"
       
        totalPrice.text = "\(SharedManager.sharedInstance.englishToArabicNumber(enNumber: "\(product.productPrice * Double(product.productCount))")) \(SharedManager.sharedInstance.currency)"
        
        self.delegate = delegate
        self.index = index
    }
    
    
    @IBAction func addAction(_ sender: Any) {
        delegate.addProduct(index: index)
    }
    
    @IBAction func subAction(_ sender: Any) {
        delegate.subProduct(index: index)
    }
    
}
