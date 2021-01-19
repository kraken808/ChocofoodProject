//
//  SmallMenuCell.swift
//  ChocofoodProject
//
//  Created by Murat Merekov on 17.01.2021.
//  Copyright © 2021 Murat Merekov. All rights reserved.
//

import Foundation
import UIKit
import SDWebImage

class SmallMenuCell: UICollectionViewCell{
    
    @IBOutlet weak var rating: UILabel!
    @IBOutlet weak var deliveryCash: UILabel!
    @IBOutlet weak var restaurantName: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var deliveryTime: UILabel!
    @IBOutlet weak var cashTenge: UILabel!
    
    
    
    
    //
        func bindData(data: Cafe){
            restaurantName.text = data.restaurant.title
    
            imageView.sd_setImage(with: URL(string: data.restaurant.image), completed: nil)
            let cost = data.delivery_tariff.conditions[0].order_min_cost
            cashTenge.text = "\(cost.formattedWithSeparator) тг"
            let rate = Double(data.restaurant.rating)
            rating.text = "\(rate*5/100)"
            deliveryCash.text = "от \(data.delivery_tariff.conditions[0].delivery_cost) тг"
    
            deliveryTime.text = "\(data.delivery_time.low_limit_minutes) мин."
        }
}
