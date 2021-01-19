//
//  Numeric + extension.swift
//  ChocofoodProject
//
//  Created by Murat Merekov on 19.01.2021.
//  Copyright © 2021 Murat Merekov. All rights reserved.
//

import Foundation
import UIKit


extension Numeric {
    var formattedWithSeparator: String { Formatter.withSeparator.string(for: self) ?? "" }
}
