//
//  Member.swift
//  MDB Socials
//
//  Created by Mudabbir Khan on 2/22/18.
//  Copyright © 2018 MHK. All rights reserved.
//

import Foundation
import UIKit

class Users {
    var fullname: String?
    var email: String?
    var username: String?
    var id: String?
    
    init(id: String, userDict: [String:Any]?) {
        self.id = id
        if userDict != nil {
            if let fullname = userDict!["fullname"] as? String {
                self.fullname = fullname
            }
            if let email = userDict!["email"] as? String {
                self.email = email
            }
            if let username = userDict!["username"] as? String {
                self.username = username
            }
        }
    }
    
    static func getCurrentUser(withId: String, block: @escaping (Users) -> ()) {
        FirebaseAPIClient.fetchUser(id: withId, withBlock: {(user) in
            block(user)
        })
    }
    
    
}
