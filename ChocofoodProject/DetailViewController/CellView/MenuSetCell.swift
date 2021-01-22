//
//  MenuSetCell.swift
//  ChocofoodProject
//
//  Created by Murat Merekov on 20.01.2021.
//  Copyright © 2021 Murat Merekov. All rights reserved.
//

import Foundation
import UIKit
import SDWebImage

class MenuSetCell: UICollectionViewCell{
    
    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var textField: UITextField!
    
    @IBOutlet weak var priceLable: UILabel!
    
    @IBOutlet weak var addButton: UIButton!
    
    
    func bindData(foods: Foods){
        nameLabel.text = foods.title
        imageView.autoresizingMask = [.flexibleWidth, .flexibleHeight, .flexibleBottomMargin, .flexibleRightMargin, .flexibleLeftMargin, .flexibleTopMargin]
        imageView.contentMode = .scaleAspectFill // OR .scaleAspectFill
        imageView.clipsToBounds = true
        if let url = foods.logo {
            imageView.sd_setImage(with: URL(string: url), completed: nil)
        }
        
        imageView.image = UIImage(named: "tenge")
        priceLable.text = "\(foods.price)"
        textField.text = "vsem salam"
    }
}
