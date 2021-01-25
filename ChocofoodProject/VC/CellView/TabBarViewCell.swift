//
//  TabBarViewCell.swift
//  ChocofoodProject
//
//  Created by Murat Merekov on 21.01.2021.
//  Copyright © 2021 Murat Merekov. All rights reserved.
//

import Foundation
import UIKit
class TabBarViewCell: UICollectionViewCell{
    
    @IBOutlet weak var nameLabel: UILabel!
    override func awakeFromNib() {
           
           super.awakeFromNib()
           
           /*
            *  To avoid compression of labels, the below code must be present.
            */
           
           contentView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
       }
}
