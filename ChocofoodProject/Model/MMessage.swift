//
//  MMessage.swift
//  ChocofoodProject
//
//  Created by Murat Merekov on 09.01.2021.
//  Copyright © 2021 Murat Merekov. All rights reserved.
//

import Foundation

class MMessage: Codable{
    var id: Int?
    var message: String
    init(message: String){
        self.message = message
    }
}
