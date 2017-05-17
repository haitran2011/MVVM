//
//  SuperMarketCell.swift
//  MagadiHome
//
//  Created by Mustafa Ezzat on 5/9/17.
//  Copyright © 2017 Waqood. All rights reserved.
//

import UIKit

class SuperMarketCell: UITableViewCell {
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var logoImage: UIImageView!
    @IBOutlet weak var goImage: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configure(with superMarket:SuperMarketViewModel) {
        name.text = superMarket.name_ar
        APIManager.sharedInstance.downloadImg(imgView: logoImage, with: superMarket.logo, placeholderImage: SharedManager.sharedInstance.placeHolderFlag)
        
        if let _img = goImage?.image {
            goImage?.image = UIImage(cgImage: _img.cgImage!, scale:_img.scale , orientation: UIImageOrientation.upMirrored)
        }
    }
}
