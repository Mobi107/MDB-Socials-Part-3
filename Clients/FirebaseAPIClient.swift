//
//  FirebaseAPIClient.swift
//  MDB Socials
//
//  Created by Mudabbir Khan on 2/22/18.
//  Copyright © 2018 MHK. All rights reserved.
//

import Foundation
import Firebase

class FirebaseAPIClient {
    static func fetchEvents(withBlock: @escaping ([Event]) -> ()) {
        //TODO: Implement a method to fetch posts with Firebase!
        let ref = Database.database().reference()
        ref.child("Events").observe(.childAdded, with: { (snapshot) in
            let event = Event(id: snapshot.key, postDict: snapshot.value as! [String : Any]?)
            withBlock([event])
        })
    }
    
    static func fetchUser(id: String, withBlock: @escaping (Users) -> ()) {
        //TODO: Implement a method to fetch posts with Firebase!
        let ref = Database.database().reference()
        ref.child("Users").child(id).observeSingleEvent(of: .value, with: { (snapshot) in
            let user = Users(id: snapshot.key, userDict: snapshot.value as! [String : Any]?)
            withBlock(user)
            
        })
    }
    
    static func createNewEvent(imageData: Data, withBlock: @escaping (String, String) -> ()) {
        let postsRef = Database.database().reference().child("Events")
        let key = postsRef.childByAutoId().key
        let storage = Storage.storage().reference().child("eventpics/\(key)")
        let metadata = StorageMetadata()
        metadata.contentType = "image/jpeg"
        storage.putData(imageData, metadata: metadata).observe(.success) { (snapshot) in
            let url = snapshot.metadata?.downloadURL()?.absoluteString
            withBlock(url!, key)
        }
    }
    
    static func createEvent(id: String, title: String, creator: String, creatorId: String, description: String, date: String, imageURL: String) {
        let postsRef = Database.database().reference().child("Events")
        let newPost = ["title": title, "creator": creator, "creatorId": creatorId, "description": description, "date": date, "imageURL": imageURL] as [String : Any]
        let childUpdates = ["/\(id)/": newPost]
        postsRef.updateChildValues(childUpdates)
    }
    
    static func createNewUser(id: String, fullname: String, email: String, username: String, imageURL: String) {
        let usersRef = Database.database().reference().child("Users")
        let newUser = ["fullname": fullname, "email": email, "username": username, "imageURL": imageURL]
        let childUpdates = ["/\(id)/": newUser]
        usersRef.updateChildValues(childUpdates)
    }
}
