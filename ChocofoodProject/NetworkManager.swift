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
 
    func getData<T: Codable>(path: String, method: RequestMethod, params: JSON, completion: @escaping (Result<T,Error>) -> Void) {
        
        // Adding common parameters
            var parameters = params
                
        //        if let token = KeychainWrapper.itemForKey("application_token") {
        //            parameters["token"] = token
        //        }
        //
        //        KeychainWrapper.standard


                // Creating the URLRequest object
    let request = URLRequest(baseUrl: baseUrl, path: path, method: method, params: params)
        
        
            let session = URLSession(configuration: .default)
           session.dataTask(with: request) { data, response, error in
              if let error = error {
                completion(.failure(ServiceError.noInternetConnection))
                           return
                       }
                       let response = response as! HTTPURLResponse
                       let status = response.statusCode
           
                       guard status == 200 else {
                       let apiErrorMessage: ApiErrorMessage
                        guard let data = data else { return }
                        do{
                           
                            apiErrorMessage = try JSONDecoder().decode(ApiErrorMessage.self, from: data)
                            completion(.failure(ServiceError.custom(apiErrorMessage.message)))
                        } catch _ {
                           
                            apiErrorMessage = ApiErrorMessage(message: "Error fetching data!")
                        }
                        print(apiErrorMessage)
                           return
            }
            self.setCookies(response: response)
              if let data = data {
                
                  do {
                     let result = try JSONDecoder().decode(T.self, from: data)
                     
                    completion(.success(result))
                  } catch let error {
                     print(error)
                  }
               }
            
           }.resume()
     
    }
    
    func postData<T: Codable>(path: String, method: RequestMethod, params: JSON, completion: @escaping (Result<T,Error>) -> Void) {

                //create the url with URL
        var request = URLRequest(baseUrl: baseUrl, path: path, method: method, params: params)
              

            let session: URLSession = URLSession(configuration: .default, delegate: nil, delegateQueue: nil)

                let task = session.dataTask(with: request, completionHandler: { data, response, error in

                    guard error == nil else {
                        return
                    }
                    let response = response as! HTTPURLResponse
                                    let status = response.statusCode
                    guard  (200...299).contains(status) else {
                                         print("salam")
                                         return
                                     }
                    guard let data = data else { return }
                     do{
                         let json = try JSONSerialization.jsonObject(with: data, options: [])
                         print("-------\n")
                         print(json)
                         print("-------\n")
                     }catch let error{
                         print(error.localizedDescription)
                     }


                })
                task.resume()
            }
 
    private func setCookies(response: URLResponse) {

        if let httpResponse = response as? HTTPURLResponse {
               if let headerFields = httpResponse.allHeaderFields as? [String: String] {
                let cookies = HTTPCookie.cookies(withResponseHeaderFields: headerFields, for: response.url!)
                   print(cookies)
               }
           }
    }
}
