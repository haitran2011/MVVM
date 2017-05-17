//
//  CountryCell.swift
//  MVVM
//
//  Created by Mustafa Ezzat on 5/7/17.
//  Copyright © 2017 Mustafa Ezzat. All rights reserved.
//
import Foundation
import UIKit

class CountryCell: UICollectionViewCell {

    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var checkImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func configure(with country:CountryViewModel) {
        name.text = country.name_ar
        if country.isChecked {
            checkImage.image = UIImage.init(named: AppConstant.Images.Checked)
        }
        else{
            checkImage.image = UIImage.init(named: AppConstant.Images.Unchecked)
        }
        
        APIManager.sharedInstance.downloadImg(imgView: imageView, with: country.flag, placeholderImage: SharedManager.sharedInstance.placeHolderFlag)
    }
}
