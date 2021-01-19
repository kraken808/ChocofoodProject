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
      
        var queryItems = [] as [URLQueryItem]
        
        switch method{
        case .get,.delete:
            for (key,value) in params {
                let item = URLQueryItem(name: key, value: String(describing: value))
                queryItems.append(item)
            }
        default:
            break
            
        }
        
        let url = URL(baseUrl: baseUrl, path: path, queryItems: queryItems)
        
        print("url: \(url)")
        var request = URLRequest(url: url)
        
        request.httpMethod = method.rawValue
        request.setValue("application/json", forHTTPHeaderField: "Content-Type") // the request is JSON
        request.setValue("application/json", forHTTPHeaderField: "Accept") // the response expected to be in JSON format
        switch method {
        case .post, .put:
            request.httpBody = try! JSONSerialization.data(withJSONObject: params, options: [])
        default:
            break
        }
        
        let session = URLSession(configuration: .default)
        
        session.dataTask(with: request) { data, response, error in
            guard error == nil else {
                completion(.failure(APIError.connectionEror))
                print(error!)
                return
            }
            
            guard let data = data else {
                completion(.failure(APIError.errorFetchingdata))
                return
            }
            
            let response = response as! HTTPURLResponse
            let status = response.statusCode
            
            guard status == 200 else {
                let statusResonse: StatusResponse
                
                do{
                    let result = try JSONSerialization.jsonObject(with: data, options: [])
                
                    statusResonse = try JSONDecoder().decode(StatusResponse.self, from: data)
                    
                    completion(.failure(APIError.message(statusResonse.message)))
                } catch _ {
                    
                    statusResonse = StatusResponse(message: "Error fetching data!")
                }
             
                return
            }
            
            
            
            do {
                let result = try JSONDecoder().decode(T.self, from: data)
                //                     let result = try JSONSerialization.jsonObject(with: data, options: [])
                
                completion(.success(result))
            } catch {
                print("Error: Trying to convert JSON data to string")
                return
            }
        
        }.resume()
        
    }
    
}
