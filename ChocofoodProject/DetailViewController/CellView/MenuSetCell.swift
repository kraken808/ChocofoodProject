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
    
  
    @IBOutlet weak var infoLabel: UILabel!
    
    @IBOutlet weak var priceLable: UILabel!
    
    @IBOutlet weak var addButton: UIButton!
    
    override func awakeFromNib() {
              
              super.awakeFromNib()
              
            //           layer.shadowColor = UIColor.lightGray.cgColor
              //           layer.shadowOffset = CGSize(width: 0, height: 2.0)
              //           layer.shadowRadius = 5.0
              //           layer.shadowOpacity = 1.0
              //           layer.masksToBounds = false
              //           layer.shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius: contentView.layer.cornerRadius).cgPath
              //           layer.backgroundColor = UIColor.clear.cgColor
              //
              //           contentView.layer.masksToBounds = true
              //           layer.cornerRadius = 10
              contentView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
          }
   
    
    func bindData(foods: Foods){
        nameLabel.text = foods.title
        imageView.autoresizingMask = [.flexibleWidth, .flexibleHeight, .flexibleBottomMargin, .flexibleRightMargin, .flexibleLeftMargin, .flexibleTopMargin]
        imageView.contentMode = .scaleAspectFill // OR .scaleAspectFill
        imageView.clipsToBounds = true
        if let url = foods.logo {
            imageView.sd_setImage(with: URL(string: url), completed: nil)
        }
        
       
        priceLable.text = "\(foods.price)"
        infoLabel.text = foods.selling_text
        
    }
   
}
