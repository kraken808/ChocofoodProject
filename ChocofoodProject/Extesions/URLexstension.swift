//
//  URLexstension.swift
//  ChocofoodProject
//
//  Created by Murat Merekov on 11.01.2021.
//  Copyright © 2021 Murat Merekov. All rights reserved.
//

import Foundation
import UIKit

extension URL {
    init(baseUrl: String, path: String, params: JSON, method: RequestType) {
        var components = URLComponents(string: baseUrl)!
        components.path += path
        
        switch method {
        case .get, .delete:
            components.queryItems = params.map {
                URLQueryItem(name: $0.key, value: String(describing: $0.value))
            }
        default:
            break
        }
        
        self = components.url!
        print("--------\n")
        print(components.url!)
        print("--------\n")
    }
}

extension URLRequest {
    init(baseUrl: String, path: String, method: RequestType, params: JSON) {
        let url = URL(baseUrl: baseUrl, path: path, params: params, method: method)
        self.init(url: url)
        httpMethod = method.rawValue
        setValue("application/json", forHTTPHeaderField: "Content-Type") // the request is JSON
        setValue("application/json", forHTTPHeaderField: "Accept") // the response expected to be in JSON format
        switch method {
        case .post, .put:
           httpBody = try! JSONSerialization.data(withJSONObject: params, options: [])
        default:
            break
        }
    }
}
