//
//  UserAuthHelper.swift
//  MDB Socials
//
//  Created by Mudabbir Khan on 2/22/18.
//  Copyright © 2018 MHK. All rights reserved.
//

import Foundation
import Firebase

class UserAuthHelper {
    
    static func logIn(email: String, password: String, withBlock: @escaping (User?)->()) {
        Auth.auth().signIn(withEmail: email, password: password, completion: { (user: User?, error) in
            if error == nil {
                withBlock(user)
            }
        })
    }
    
    static func logOut(withBlock: @escaping ()->()) {
        print("logging out")
        //TODO: Log out using Firebase!
        let firebaseAuth = Auth.auth()
        do {
            try firebaseAuth.signOut()
            withBlock()
        } catch let signOutError as NSError {
            print ("Error signing out: %@", signOutError)
        }
    }
    
    static func createUser(email: String, password: String, imageData: Data, withBlock: @escaping (String, String) -> ()) {
        Auth.auth().createUser(withEmail: email, password: password, completion: { (user: User?, error) in
            if error == nil {
                let storage = Storage.storage().reference().child("profilepics/\((user?.uid)!)")
                let metadata = StorageMetadata()
                metadata.contentType = "image/jpeg"
                storage.putData(imageData, metadata: metadata).observe(.success) { (snapshot) in
                    let url = snapshot.metadata?.downloadURL()?.absoluteString
                    withBlock(url!, (user?.uid)!)
                }
            }
            else {
                print(error.debugDescription)
            }
        })
    }
}
