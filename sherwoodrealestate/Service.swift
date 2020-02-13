////
////  ViewController.swift
////  SessionTest
////
////  Created by Alex Beattie on 5/13/19.
////  Copyright © 2019 Alex Beattie. All rights reserved.
////
//
import Foundation

class Service {
    
    static let shared = Service()
    
    func fetchSherwood(completion: @escaping ([Result], Error?) -> ()) {
        print("fetched items from service layer")
        
            let urlString = "https://sherwoodrealestate.s3.amazonaws.com/about-sherwood.json"
            guard let url = URL(string: urlString) else { return }

            URLSession.shared.dataTask(with: url) { (data, resp, err) in
                if let err = err {
                    print("Failed to fetch apps", err)
                    completion([], nil)
                    return
                }
                //success
                    //print(data)
                guard let data = data else { return }
                //print(String(data: data, encoding: .utf8))
                do {
                    let teamResult = try JSONDecoder().decode(TeamResult.self, from: data)
                    
                    print(teamResult)
                    completion(teamResult.Results, nil)
                   // teamResult.Results.forEach({print($0.Representative, $0.JobTitle, $0.PublicRemarks, $0.imageUrl)})

                   // these arent accessible from this file
                    
                    //self.teamResults = teamResult.Results
                    //DispatchQueue.main.async() {
                      //  self.collectionView.reloadData()
                    //}

                } catch let jsonErr {
                    print("Failed to decode JSON", jsonErr)
                    completion([], jsonErr)
                }


            }.resume()

        
    }
}
