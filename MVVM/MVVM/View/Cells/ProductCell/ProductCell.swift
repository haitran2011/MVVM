//
//  ProductCell.swift
//  MagadiHome
//
//  Created by Mustafa Ezzat on 5/10/17.
//  Copyright © 2017 Waqood. All rights reserved.
//

import UIKit

class ProductCell: UITableViewCell {
    @IBOutlet weak var productImageView: UIImageView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var price: UILabel!
    @IBOutlet weak var company_name: UILabel!
    @IBOutlet weak var size: UILabel!
    @IBOutlet weak var count: UILabel!
    
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
    
    func configure(with product:ProductViewModel, delegate:ProductCellDelegate, index:Int) {
        name.text = product.name_ar
        price.text = "\(SharedManager.sharedInstance.englishToArabicNumber(enNumber: "\(product.price)")) \(SharedManager.sharedInstance.currency)"
        size.text = product.size_ar
        company_name.text = product.company_name
        count.text = "\(SharedManager.sharedInstance.englishToArabicNumber(enNumber: "\(product.count)"))"
        
        self.delegate = delegate
        self.index = index
        
        APIManager.sharedInstance.downloadImg(imgView: productImageView, with: product.image, placeholderImage: SharedManager.sharedInstance.placeHolderFlag)
    }

    
    @IBAction func addAction(_ sender: Any) {
        delegate.addProduct(index: index)
    }
    
    @IBAction func subAction(_ sender: Any) {
        delegate.subProduct(index: index)
    }
}
