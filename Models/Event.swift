//
//  Post.swift
//  MDB Socials
//
//  Created by Mudabbir Khan on 2/22/18.
//  Copyright © 2018 MHK. All rights reserved.
//

import Foundation
import UIKit
import Firebase

class Event {
    var title: String?
    var creatorId: String?
    var description: String?
    var date: Date?
    var creator: String?
    var imageData: Data?
    var id: String?
    var image: UIImage?
    
    
    init(id: String, postDict: [String:Any]?) {
        self.id = id
        if postDict != nil {
            if let title = postDict!["title"] as? String {
                self.title = title
            }
            if let creatorId = postDict!["creatorId"] as? String {
                self.creatorId = creatorId
            }
            if let creator = postDict!["creator"] as? String {
                self.creator = creator
            }
            if let description = postDict!["description"] as? String {
                self.description = description
            }
            if let date = postDict!["date"] as? Date {
                self.date = date
            }
        }
    }
    
    func getEventPic(withBlock: @escaping () -> ()) {
        //TODO: Get User's profile picture
        let ref = Storage.storage().reference().child("/eventpics/\(id!)")
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
