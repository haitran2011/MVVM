//
//  CityCell.swift
//  MVVM
//
//  Created by Mustafa Ezzat on 5/8/17.
//  Copyright © 2017 Mustafa Ezzat. All rights reserved.
//

import UIKit

class CityCell: UITableViewCell {
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var checkedImg: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configure(with city:CityViewModel) {
        name.text = city.name_ar
        if city.isChecked {
            checkedImg.image = UIImage.init(named: AppConstant.Images.Checked)
        }
        else{
            checkedImg.image = UIImage.init(named: AppConstant.Images.Unchecked)
        }
    }

    
}
