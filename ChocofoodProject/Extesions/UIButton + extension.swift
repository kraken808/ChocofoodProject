//
//  UIButton + extension.swift
//  ChocofoodProject
//
//  Created by Murat Merekov on 20.01.2021.
//  Copyright © 2021 Murat Merekov. All rights reserved.
//

import Foundation
import UIKit

@IBDesignable class MyButton: UIButton
{
    override func layoutSubviews() {
        super.layoutSubviews()

        updateCornerRadius()
    }

    @IBInspectable var rounded: Bool = false {
        didSet {
            updateCornerRadius()
        }
    }

    func updateCornerRadius() {
        layer.cornerRadius = rounded ? frame.size.height / 2 : 0
    }
}
