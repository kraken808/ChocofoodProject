//
//  Client.swift
//  ChocofoodProject
//
//  Created by Murat Merekov on 11.01.2021.
//  Copyright © 2021 Murat Merekov. All rights reserved.
//

import Foundation
import UIKit



final class WebClient  {
    
    
    private var baseUrl: String
    
    init(baseUrl: String) {
        self.baseUrl = baseUrl
    }
    
    func load(path: String, method: RequestMethod, params: JSON, completion: @escaping (Any?, ServiceError?) -> ()) -> URLSessionDataTask? {
        // Checking internet connection availability
//        if !Reachability.isConnectedToNetwork() {
//            completion(nil, ServiceError.noInternetConnection)
//            return nil
//        }




        // Adding common parameters
        var parameters = params
        
//        if let token = KeychainWrapper.itemForKey("application_token") {
//            parameters["token"] = token
//        }
//
//        KeychainWrapper.standard


        // Creating the URLRequest object
        let request = URLRequest(baseUrl: baseUrl, path: path, method: method, params: params)




        // Sending request to the server.
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            // Parsing incoming data
            var object: Any? = nil
            if let data = data {
                object = try? JSONSerialization.jsonObject(with: data, options: [])
            }
            
            if let httpResponse = response as? HTTPURLResponse, (200..<300) ~= httpResponse.statusCode {
                completion(object, nil)
            } else {
//                let error = (object as? JSON).flatMap(ServiceError.init) ?? ServiceError.other
//                completion(nil, error)
            }
        }
        
        task.resume()
        
        return task
    }
}
