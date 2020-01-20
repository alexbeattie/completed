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
class Service {
    static let shared = Service() // singleton
    func fetchAuthToken(completion: @escaping (SoldListings.responseData) -> ()) {
        
        let request = NSMutableURLRequest(url: URL(string: "https://sparkapi.com/v1/session?ApiKey=vc_c15909466_key_1&ApiSig=a2b8a9251df6e00bf32dd16402beda91")!)
        request.httpMethod = "POST"
        request.cachePolicy = NSURLRequest.CachePolicy.reloadIgnoringCacheData
        request.addValue("SparkiOS", forHTTPHeaderField: "X-SparkApi-User-Agent")
        let task = URLSession.shared.dataTask(with: request as URLRequest) {
            data, response, error in
            if let json = data {
                do {
                    let tokenResponse = try JSONDecoder().decode(SoldListings.responseData.self, from: json)
                    print(tokenResponse.D.Results)
                    let authToken = tokenResponse.D.Results[0].AuthToken
                    print("This is the authToken: \(authToken)")

                    completion(tokenResponse)

                } catch {
                    print(error)
                }
            }
        }
        task.resume()
    }
}
