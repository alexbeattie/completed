////
////  ViewController.swift
////  SessionTest
////
////  Created by Alex Beattie on 5/13/19.
////  Copyright © 2019 Alex Beattie. All rights reserved.
////
//
import Foundation
//


struct Service {
    struct responseData: Codable {
        var D: ResultsData?
    }
    struct ResultsData: Codable {
        var Results: [resultsArr]?
    }
    struct resultsArr: Codable {
        var AuthToken: String?
        var Expires: String?
        
    }
    static let shared = Service() // singleton
    func fetchAuthToken(completion: @escaping (responseData) -> ()) {
        var request = URLRequest(url: URL(string: "\(SESSION_URL)")!)
        let config = URLSessionConfiguration.default
        let session = URLSession(configuration: config)

        request.httpMethod = "POST"
//        request.cachePolicy = NSURLRequest.CachePolicy.reloadIgnoringCacheData
        request.addValue("SparkiOS", forHTTPHeaderField: "X-SparkApi-User-Agent")
//        request.setValue("application/json", forHTTPHeaderField: "Accept")
//        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
//        let newTodoItem = resultsArr(AuthToken:self, Expires: self)
//        let jsonData = try JSONEncoder().encode(resultsArr)
//        request.httpBody = jsonData
        
        let task = session.dataTask(with: request as URLRequest) { data, response, error in
            if let error = error {
                print("Error took place \(error)")
                return
            }
            //            guard let data = data else {return}
            
            //            if let data = data, let dataString = String(data: data, encoding: .utf8) {
            //                print("Response data string:\n \(dataString)")
            //
            //            }
            if let json = data {
                do {
                    let tokenResponse = try JSONDecoder().decode(responseData.self, from: json)
                    print(tokenResponse.D?.Results)
                    let authToken = tokenResponse.D?.Results?[0].AuthToken
                    print("This is the authToken: \(authToken)")
                    
                    completion(tokenResponse)
                    
                    
                } catch {
                    print(error)
                }
            }
        }
            
                    task.resume()
            
//            if let json = data {
//
//                    let tokenResponse = try JSONDecoder().decode(responseData.self, from: json)
//                    print(tokenResponse.D.Results)
//                    let authToken = tokenResponse.D.Results[0].AuthToken
//                    print("This is the authToken: \(authToken)")
//                    request.httpBody = data
//
//                    completion(tokenResponse)
//            }
////            print(data)
//
//        }
//        task.resume()
            
            
            
//            if let json = data {
//                do {
//                    let tokenResponse = try JSONDecoder().decode(responseData.self, from: json)
//                    print(tokenResponse.D.Results)
//                    let authToken = tokenResponse.D.Results[0].AuthToken
//                    print("This is the authToken: \(authToken)")
//
//                    completion(tokenResponse)
//
//                    
//                } catch {
//                    print(error)
//                }
//            }
//        }
//
//        task.resume()
    }
}
