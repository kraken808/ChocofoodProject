//
//  Page.swift
//  ChocofoodProject
//
//  Created by Murat Merekov on 21.01.2021.
//  Copyright © 2021 Murat Merekov. All rights reserved.
//

import Foundation
import UIKit

struct Page {
    
    var name = ""
    var vc = UIViewController()
    
    init(with _name: String, _vc: UIViewController) {
        
        name = _name
        vc = _vc
    }
}

struct PageCollection {
    
    var pages = [Page]()
    var selectedPageIndex = 0 //The first page is selected by default in the beginning
}
