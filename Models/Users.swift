//
//  Member.swift
//  MDB Socials
//
//  Created by Mudabbir Khan on 2/22/18.
//  Copyright © 2018 MHK. All rights reserved.
//

import Foundation
import UIKit
import Firebase

class Users {
    var fullname: String?
    var email: String?
    var username: String?
    var imageURL: String?
    var id: String?
    var interestedEventIds = [String]()
    var image: UIImage?
    
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
            if let imageURL = userDict!["imageURL"] as? String {
                self.imageURL = imageURL
            }
            if let interestedEventIds = userDict!["interestedEventIds"] as? [String] {
                self.interestedEventIds = interestedEventIds
            }
        }
    }
    
    static func getCurrentUser(withId: String, block: @escaping (Users) -> ()) {
        FirebaseAPIClient.fetchUser(id: withId, withBlock: {(user) in
            block(user)
        })
    }
    
    func getProfilePic(withBlock: @escaping () -> ()) {
        //TODO: Get User's profile picture
        let ref = Storage.storage().reference().child("/profilepics/\(id!)")
        ref.getData(maxSize: 1 * 2048 * 2048) { data, error in
            if let error = error {
                print(error)
            } else {
                self.image = UIImage(data: data!)
                withBlock()
            }
        }
    }
}
