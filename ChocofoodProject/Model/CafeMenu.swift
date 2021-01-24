//
//  CafeMenu.swift
//  ChocofoodProject
//
//  Created by Murat Merekov on 20.01.2021.
//  Copyright © 2021 Murat Merekov. All rights reserved.
//

import Foundation
import UIKit

struct CafeMenu: Codable{
    var food_types: [Food_types]
}

struct Food_types: Codable{
    var title: String
    var dishes_cost: Int
//    var external_service_id: String?
    var oid: String
    var position: Int
    var foods: [Foods]
}

struct Foods: Codable{
    var title: String
//    var state: String
    var price: Int
   var logo: String?
    var selling_text: String
//    var external_service_id: String?
//   var measure: String?
//    var cooking_method: String?
//    var oid: String
    var position: Int
    
   
}




