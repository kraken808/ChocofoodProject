//
//  MenuViewCell.swift
//  ChocofoodProject
//
//  Created by Murat Merekov on 07.01.2021.
//  Copyright © 2021 Murat Merekov. All rights reserved.
//

import UIKit
import SDWebImage

class MenuCell: UICollectionViewCell {

 
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var restaurantName: UILabel!
    @IBOutlet weak var rating: UILabel!
 
    @IBOutlet weak var deliveryCash: UILabel!
    @IBOutlet weak var cashTenge: UILabel!
    @IBOutlet weak var deliveryTime: UILabel!
    
   
   
    func bindData(data: Cafe) {
        self.contentView.backgroundColor = .blue
        restaurantName.text = data.restaurant.title
        imageView.sd_setImage(with: URL(string: data.restaurant.image), completed: nil)
        rating.text = "\(data.restaurant.rating)"
        deliveryCash.text = "от \(data.delivery_tariff.conditions[0].delivery_cost)"
        cashTenge.text = "\(data.delivery_tariff.conditions[0].order_min_cost) тг"
        deliveryTime.text = "\(data.delivery_time.low_limit_minutes)"
    }
    
}
