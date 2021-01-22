//
//  File.swift
//  ChocofoodProject
//
//  Created by Murat Merekov on 13.01.2021.
//  Copyright © 2021 Murat Merekov. All rights reserved.
//

import UIKit

//-------------------------------------------------------------------------------------------------------------------------------------------------
extension UIView {

    //---------------------------------------------------------------------------------------------------------------------------------------------
    @IBInspectable
    var cornerRadius: CGFloat {

        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
            layer.masksToBounds = newValue > 0
        }
    }

    //---------------------------------------------------------------------------------------------------------------------------------------------
    @IBInspectable
    var borderWidth: CGFloat {

        get {
            return layer.borderWidth
        }
        set {
            layer.borderWidth = newValue
        }
    }

    //---------------------------------------------------------------------------------------------------------------------------------------------
    @IBInspectable
    var borderColor: UIColor? {

        get {
            let color = UIColor.init(cgColor: layer.borderColor!)
            return color
        }
        set {
            layer.borderColor = newValue?.cgColor
        }
    }
   
       func roundCorners(corners: UIRectCorner, radius: CGFloat) {
            let path = UIBezierPath(roundedRect: bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
            let mask = CAShapeLayer()
            mask.path = path.cgPath
            layer.mask = mask
        }
    
}
