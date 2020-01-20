//
//  CustomFields.swift
//  sherwoodrealestate
//
//  Created by Alex Beattie on 12/7/19.
//  Copyright © 2019 Alex Beattie. All rights reserved.
//

import Foundation

var CustomFields: [customFields]?

struct customFields:Codable{
    var Main:[MainDictionary]?
    struct MainDictionary: Codable {
       
        var listingLocationPropertyInfo: [listingLocationArray]?
        
        enum CodingKeys: String, CodingKey {
            case listingLocationPropertyInfo = "Listing, Location and Property Info"
        }
            struct listingLocationArray:Codable {
                var entryDate: String
                enum CodingKeys: String, CodingKey {
                    case entryDate = "Entry Date"
                }
            }
        }
}
