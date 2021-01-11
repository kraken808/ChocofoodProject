//
//  EndPointType.swift
//  ChocofoodProject
//
//  Created by Murat Merekov on 08.01.2021.
//  Copyright © 2021 Murat Merekov. All rights reserved.
//
import UIKit
import Foundation
protocol EndPointType {
    var baseURL: URL { get }
    var path: String {get}
    var httpMethod: RequestMethod { get }
}

