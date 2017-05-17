//
//  CountryCell.swift
//  MagadiHome
//
//  Created by Mustafa Ezzat on 5/7/17.
//  Copyright © 2017 Waqood. All rights reserved.
//
import Foundation
import UIKit

class CategoryCell: UICollectionViewCell {

    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func configure(with category:CategoryViewModel) {
        name.text = category.name
        APIManager.sharedInstance.downloadImg(imgView: imageView, with: category.image, placeholderImage: SharedManager.sharedInstance.placeHolderFlag)
    }
}
