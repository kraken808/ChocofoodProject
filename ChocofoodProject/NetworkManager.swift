//
//  NetworkManager.swift
//  ChocofoodProject
//
//  Created by Murat Merekov on 07.01.2021.
//  Copyright © 2021 Murat Merekov. All rights reserved.
//

import UIKit
import Foundation

class NetworkManager {

    static func fetch<T: Codable>(url: String, completion: @escaping (T) -> Void) {
        
        if let url = URL(string: url) {
           URLSession.shared.dataTask(with: url) { data, message, error in
              if let data = data {
                  do {
                     let result = try JSONDecoder().decode(T.self, from: data)
                     print(result)
                     completion(result)
                  } catch let error {
                     print(error)
                  }
               }
           }.resume()
        }
    }

    
}
