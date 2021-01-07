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

    private static let endpoint = "https://api.jsonbin.io/b/5ff1946009f7c73f1b6d134f"
   
    static func getCafes(completion: @escaping ([Cafe]) -> Void) {
        
        if let url = URL(string: endpoint) {
           URLSession.shared.dataTask(with: url) { data, message, error in
              if let data = data {
                  do {
                     let result = try JSONDecoder().decode([Cafe].self, from: data)
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
