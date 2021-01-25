//
//  LayerSetup.swift
//  ChocofoodProject
//
//  Created by Murat Merekov on 25.01.2021.
//  Copyright © 2021 Murat Merekov. All rights reserved.
//

import UIKit


extension UICollectionViewCell{
    func layerSetup(shadowColor: CGColor = #colorLiteral(red: 0.5922273993, green: 0.6035784483, blue: 0.6143382192, alpha: 1), cornerR: CGFloat = 4){
        self.backgroundColor = .white
                               self.layer.cornerRadius = cornerR
                               self.layer.shadowColor = shadowColor
                               self.layer.shadowRadius = 3
                               self.layer.shadowOpacity = 0.7
                               self.layer.shadowOffset = CGSize(width: 0, height: 4)
                               self.layer.masksToBounds = false
    }
}
