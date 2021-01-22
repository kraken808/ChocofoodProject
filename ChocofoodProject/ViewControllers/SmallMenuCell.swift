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
            imageView.autoresizingMask = [.flexibleWidth, .flexibleHeight, .flexibleBottomMargin, .flexibleRightMargin, .flexibleLeftMargin, .flexibleTopMargin]
            imageView.contentMode = .scaleAspectFill // OR .scaleAspectFill
            imageView.clipsToBounds = true
            imageView.sd_setImage(with: URL(string: data.restaurant.image), completed: nil)
            
            let cost = data.delivery_tariff.conditions[0].order_min_cost
            cashTenge.text = "\(cost.formattedWithSeparator) тг"
            let rate = Double(data.restaurant.rating)*5/100
            let rateStr = String(format: "%.1f", rate)
            rating.text = rateStr
            deliveryCash.text = "от \(data.delivery_tariff.conditions[0].delivery_cost) тг"
    
            deliveryTime.text = "\(data.delivery_time.low_limit_minutes) мин."
        }
    func contentMode(image: UIImage?)->UIView.ContentMode{
        guard let image = image else { return .scaleAspectFill }
          let viewAspectRatio = imageView.bounds.width / imageView.bounds.height
          let imageAspectRatio = image.size.width / image.size.height
          if viewAspectRatio > imageAspectRatio {
             return .scaleAspectFill
          } else {
              return .scaleAspectFit
          }
    }
}
