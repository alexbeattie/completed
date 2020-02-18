//
//  TosService.swift
//  sherwoodrealestate
//
//  Created by Alex Beattie on 2/15/20.
//  Copyright © 2020 Alex Beattie. All rights reserved.
//

import Foundation
class TosService {
    static let shared = TosService()

func fetchDisclaimer(completion: @escaping ([Disclaimer], Error?) -> ()) {
    print("fetched items from tosservice layer")
    
        let urlString = "https://sherwoodrealestate.s3.amazonaws.com/disclaimer.json"
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
                let disclaimerFrom = try JSONDecoder().decode(DisclaimerModel.self, from: data)
                
                print(disclaimerFrom)
                completion(disclaimerFrom.Disclaimers, nil)
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
