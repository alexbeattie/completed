//
//  UserSessionPrototype.swift
//  sherwoodrealestate
//
//  Created by Alex Beattie on 1/28/20.
//  Copyright © 2020 Alex Beattie. All rights reserved.
//

import Foundation

struct UserSessionPrototype {

    let identifier: String
    let userInfo: [String: AnyObject]

    init(response: [String: AnyObject]) {
        // Dirty parsing to simplify our example
        let result = response["result"] as! [String: AnyObject]
        let user = result["user"] as! [String: AnyObject]

        identifier = user["id"] as! String
        userInfo = user
    }
}
