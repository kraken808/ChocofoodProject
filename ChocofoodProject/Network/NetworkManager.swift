//
//  NetworkManager.swift
//  ChocofoodProject
//
//  Created by Murat Merekov on 07.01.2021.
//  Copyright © 2021 Murat Merekov. All rights reserved.
//

import UIKit
import Foundation

typealias JSON = [String: Any]

class NetworkManager {
    
    private var baseUrl: String
     
     init(baseUrl: String) {
         self.baseUrl = baseUrl
     }
 
    func request<T: Codable>(path: String, method: RequestType, params: JSON = [:], completion: @escaping (Result<T,Error>) -> Void) {

       let request = URLRequest(baseUrl: baseUrl, path: path, method: method, params: params)
       let session = URLSession(configuration: .default)
        
           session.dataTask(with: request) { data, response, error in
                     guard error == nil else {
                                   completion(.failure(ServiceError.connectionEror))
                                  print(error!)
                                  return
                              }
                    guard let data = data else {
                        completion(.failure(ServiceError.errorFetchingdata))
                        return
                    }
                       let response = response as! HTTPURLResponse
                       let status = response.statusCode
           
                       guard status == 200 else {
                       let apiErrorMessage: ApiErrorMessage
                       
                        do{
                            apiErrorMessage = try JSONDecoder().decode(ApiErrorMessage.self, from: data)
                
                            completion(.failure(ServiceError.message(apiErrorMessage.message)))
                        } catch _ {
                           
                            apiErrorMessage = ApiErrorMessage(message: "Error fetching data!")
                        }
                        print(apiErrorMessage)
                           return
                      }
            
              
                
                  do {
                     let result = try JSONDecoder().decode(T.self, from: data)
//                     let result = try JSONSerialization.jsonObject(with: data, options: [])
                    print(result)
                    completion(.success(result))
                  } catch {
                print("Error: Trying to convert JSON data to string")
                return
            }
              
            
           }.resume()
     
    }
 
  
}
