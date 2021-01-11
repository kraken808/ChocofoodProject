//
//  File.swift
//  ChocofoodProject
//
//  Created by Murat Merekov on 11.01.2021.
//  Copyright © 2021 Murat Merekov. All rights reserved.
//

import Foundation

struct Data: Codable{
    var id: String
}

struct MPost: Codable{
    var success: Bool
    var data: Data
    var message: String
}
