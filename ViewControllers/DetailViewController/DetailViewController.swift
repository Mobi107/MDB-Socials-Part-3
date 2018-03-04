//
//  DetailViewController.swift
//  MDB Socials
//
//  Created by Mudabbir Khan on 3/3/18.
//  Copyright © 2018 MHK. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    var eventTitle: UILabel!
    var eventImage: UIImageView!
    var createrImage: UIImageView!
    var createrUserName: UILabel!
    var date: UILabel!
    var eventDescription: UILabel!
    var location: UILabel!
    var event: Event!

    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavBar()
        setupPhotos()
        setupLabels()
        setupData()

        // Do any additional setup after loading the view.
    }
    
    func setupNavBar() {
        navigationItem.title = "Event Details"
    }
    
    func setupPhotos() {
        createrImage = UIImageView(frame: CGRect(x: 20, y: 84, width: 75, height: 75))
        createrImage.layoutIfNeeded()
        createrImage.layer.borderWidth = 1.0
        createrImage.layer.borderColor = UIColor.black.cgColor
        createrImage.layer.masksToBounds = true
        createrImage.layer.cornerRadius = 5
        createrImage.contentMode = .scaleAspectFill
        view.addSubview(createrImage)
        
        eventImage = UIImageView(frame: CGRect(x: 20, y: 370, width: view.frame.width - 40, height: 200))
        eventImage.layoutIfNeeded()
        eventImage.layer.borderWidth = 1.0
        eventImage.layer.borderColor = UIColor.black.cgColor
        eventImage.layer.masksToBounds = true
        eventImage.layer.cornerRadius = 5
        eventImage.contentMode = .scaleAspectFill
        view.addSubview(eventImage)
    }
    
    func setupLabels() {
        createrUserName = UILabel(frame: CGRect(x: 105, y: 120, width: view.frame.width - 95, height: 30))
        createrUserName.font = UIFont(name: "AppleSDGothicNeo-SemiBold", size: 20)
        createrUserName.textColor = .black
        createrUserName.sizeToFit()
        view.addSubview(createrUserName)
        
        eventTitle = UILabel(frame: CGRect(x: 20, y: 160, width: view.frame.width, height: 50))
        eventTitle.font = UIFont(name: "AppleSDGothicNeo-SemiBold", size: 25)
        eventTitle.textColor = .black
        eventTitle.sizeToFit()
        eventTitle.text = event.title
        view.addSubview(eventTitle)
        
        date = UILabel(frame: CGRect(x: 20, y: 220, width: view.frame.width, height: 30))
        date.font = UIFont(name: "AppleSDGothicNeo-SemiBold", size: 20)
        date.textColor = .black
        date.sizeToFit()
        date.text = event.date
        view.addSubview(date)
        
        eventDescription = UILabel(frame: CGRect(x: 20, y: 260, width: view.frame.width - 40, height: 100))
        eventDescription.textColor = .black
        eventDescription.sizeToFit()
        eventDescription.clipsToBounds = true
        eventDescription.text = event.description
        view.addSubview(eventDescription)
        
        location = UILabel(frame: CGRect(x: 20, y: 480, width: view.frame.width / 2, height: 30))
        location.font = UIFont(name: "AppleSDGothicNeo-SemiBold", size: 20)
        location.textColor = .black
        location.sizeToFit()
        location.text = "Location"
        view.addSubview(location)
    }
    
    func setupData() {
        Users.getCurrentUser(withId: event.creatorId!) { (user) in
            self.createrUserName.text = user.username
            user.getProfilePic {
                self.createrImage.image = user.image
            }
        }
        eventTitle.text = event.title
        event.getEventPic {
            self.eventImage.image = self.event.image
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
