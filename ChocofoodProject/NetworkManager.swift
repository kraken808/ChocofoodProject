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
 
    func getData<T: Codable>(path: String, method: RequestMethod, params: JSON = [:], completion: @escaping (Result<T,Error>) -> Void) {


               
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
                            print("----status start--\n")
                                                      print(status)
                                                       print("---status end---\n")
                            apiErrorMessage = try JSONDecoder().decode(ApiErrorMessage.self, from: data)
                            print("------\n")
                            print(apiErrorMessage)
                             print("------\n")
                            completion(.failure(ServiceError.custom(apiErrorMessage.message)))
                        } catch _ {
                           
                            apiErrorMessage = ApiErrorMessage(message: "Error fetching data!")
                        }
                        print(apiErrorMessage)
                           return
            }
            
              if let data = data {
                
                  do {
//                     let result = try JSONDecoder().decode(T.self, from: data)
                     let result = try JSONSerialization.jsonObject(with: data, options: [])
                    print(result)
//                    completion(.success(result as! T))
                  } catch let error {
                     print(error)
                  }
               }
            
           }.resume()
     
    }
    
       func request<T: Codable>(path: String, method: RequestMethod, params: JSON = [:], completion: @escaping (Result<T,Error>) -> Void) {
        
         guard let url = URL(string: "http://dummy.restapiexample.com/api/v1/create") else {
                    print("Error: cannot create URL")
                    return
                }
                
                // Create model
//                struct UploadData: Codable {
//                    let name: String
//                    let salary: String
//                    let age: String
//                }
                
                // Add data to the model
//                let uploadDataModel = UploadData(name: "Jack", salary: "3540", age: "23")
                
                // Convert model to JSON data
                guard let jsonData = try? JSONEncoder().encode(uploadDataModel) else {
                    print("Error: Trying to convert model to JSON data")
                    return
                }
                // Create the url request
                var request = URLRequest(url: url)
                request.httpMethod = "POST"
                request.setValue("application/json", forHTTPHeaderField: "Content-Type") // the request is JSON
                request.setValue("application/json", forHTTPHeaderField: "Accept") // the response expected to be in JSON format
                request.httpBody = jsonData
                URLSession.shared.dataTask(with: request) { data, response, error in
                    guard error == nil else {
                        print("Error: error calling POST")
                        print(error!)
                        return
                    }
                    guard let data = data else {
                        print("Error: Did not receive data")
                        return
                    }
                    guard let response = response as? HTTPURLResponse, (200 ..< 299) ~= response.statusCode else {
                        print("Error: HTTP request failed")
                        return
                    }
                    do {
                        guard let jsonObject = try JSONSerialization.jsonObject(with: data) as? [String: Any] else {
                            print("Error: Cannot convert data to JSON object")
                            return
                        }
                        guard let prettyJsonData = try? JSONSerialization.data(withJSONObject: jsonObject, options: .prettyPrinted) else {
                            print("Error: Cannot convert JSON object to Pretty JSON data")
                            return
                        }
                        guard let prettyPrintedJson = String(data: prettyJsonData, encoding: .utf8) else {
                            print("Error: Couldn't print JSON in String")
                            return
                        }
                        
                        print(prettyPrintedJson)
                    } catch {
                        print("Error: Trying to convert JSON data to string")
                        return
                    }
                }.resume()
         
        }
    
    
//    func postData<T: Codable>(path: String, method: RequestMethod, params: JSON, completion: @escaping (Result<T,Error>) -> Void) {
//
//                //create the url with URL
//        var request = URLRequest(baseUrl: baseUrl, path: path, method: method, params: params)
//
//            let session: URLSession = URLSession(configuration: .default, delegate: nil, delegateQueue: nil)
//
//                let task = session.dataTask(with: request, completionHandler: { data, response, error in
//
//                    guard error == nil else {
//                        return
//                    }
//                    let response = response as! HTTPURLResponse
//                                    let status = response.statusCode
//                    guard  (200...299).contains(status) else {
//                                         print("salam")
//                                         return
//                                     }
//                    guard let data = data else { return }
//                     do{
//                         let json = try JSONSerialization.jsonObject(with: data, options: [])
//                         print("-------\n")
//                         print(json)
//                         print("-------\n")
//                     }catch let error{
//                         print(error.localizedDescription)
//                     }
//
//
//                })
//                task.resume()
//            }
 
  
}
