//
//  DetailViewController.swift
//  MDB Socials
//
//  Created by Mudabbir Khan on 3/3/18.
//  Copyright © 2018 MHK. All rights reserved.
//

import UIKit
import Firebase

class DetailViewController: UIViewController {
    
    var eventTitle: UILabel!
    var eventImage: UIImageView!
    var createrImage: UIImageView!
    var interestedButton: UIButton!
    var createrUserName: UILabel!
    var createrName: UILabel!
    var date: UILabel!
    var eventDescription: UILabel!
    var location: UILabel!
    var event: Event!
    var user: Users!

    override func viewDidLoad() {
        super.viewDidLoad()
        Users.getCurrentUser(withId: (Auth.auth().currentUser?.uid)!, block: {(cUser) in
            self.user = cUser
            self.setupInterestedButton()
            self.setupData()
            self.setupLabels()
        })
        setupNavBar()
        setupPhotos()
        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        if self.isMovingFromParentViewController {
            FirebaseAPIClient.favoriteUser(event: event, user: user)
        }
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
        
        eventImage = UIImageView(frame: CGRect(x: 20, y: 270, width: view.frame.width - 40, height: 200))
        eventImage.layoutIfNeeded()
        eventImage.layer.borderWidth = 1.0
        eventImage.layer.borderColor = UIColor.black.cgColor
        eventImage.layer.masksToBounds = true
        eventImage.layer.cornerRadius = 5
        eventImage.contentMode = .scaleAspectFill
        view.addSubview(eventImage)
    }
    
    func setupLabels() {
        createrUserName = UILabel(frame: CGRect(x: 105, y: 110, width: view.frame.width - 95, height: 30))
        createrUserName.textColor = .black
        createrUserName.text = "@\(user.username!)"
        view.addSubview(createrUserName)
        
        createrName = UILabel(frame: CGRect(x: 105, y: 90, width: view.frame.width - 95, height: 30))
        createrName.font = UIFont(name: "AppleSDGothicNeo-SemiBold", size: 20)
        createrName.textColor = .black
        createrName.text = user.fullname!
        view.addSubview(createrName)
        
        eventTitle = UILabel(frame: CGRect(x: 20, y: 170, width: view.frame.width, height: 30))
        eventTitle.font = UIFont(name: "AppleSDGothicNeo-SemiBold", size: 25)
        eventTitle.textColor = .black
        eventTitle.text = event.title!
        view.addSubview(eventTitle)
        
        date = UILabel(frame: CGRect(x: 20, y: 200, width: view.frame.width, height: 30))
        date.font = UIFont(name: "AppleSDGothicNeo-SemiBold", size: 20)
        date.textColor = .black
        date.text = event.date!
        view.addSubview(date)
        
        eventDescription = UILabel(frame: CGRect(x: 20, y: 210, width: view.frame.width - 40, height: 60))
        eventDescription.textColor = .black
        eventDescription.clipsToBounds = true
        eventDescription.text = event.description!
        view.addSubview(eventDescription)
        
        location = UILabel(frame: CGRect(x: 20, y: 500, width: view.frame.width / 2, height: 30))
        location.font = UIFont(name: "AppleSDGothicNeo-SemiBold", size: 20)
        location.textColor = .black
        location.text = "Location"
        view.addSubview(location)
    }
    
    func setupInterestedButton() {
        interestedButton = UIButton(frame: CGRect(x: 210, y: 115, width: 150, height: 40))
        interestedButton.backgroundColor = UIColor(displayP3Red: 0.20, green: 0.60, blue: 1.0, alpha: 1.0)
        interestedButton.layoutIfNeeded()
        if (event.interestedUserIds.contains(user.id!)) {
            interestedButton.setTitle("I'm Interested!", for: .normal)
        } else {
            interestedButton.setTitle("Interested?", for: .normal)
        }
        interestedButton.setTitleColor(UIColor.white, for: .normal)
        interestedButton.titleLabel?.font = UIFont(name: "AmericanTypewriter-Bold", size: 16)
        interestedButton.layer.borderWidth = 2.0
        interestedButton.layer.cornerRadius = 10.0
        interestedButton.layer.borderColor = UIColor.black.cgColor
        interestedButton.layer.masksToBounds = true
        interestedButton.addTarget(self, action: #selector(interestedButtonClicked), for: .touchUpInside)
        self.view.addSubview(interestedButton)
    }
    
    func setupData() {
        Utils.getImage(withUrl: user.imageURL!).then {image in
            self.createrImage.image = image
        }
        Utils.getImage(withUrl: event.imageURL!).then {image in
            self.eventImage.image = image
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @objc func interestedButtonClicked(sender: UIButton) {
        if (event.interestedUserIds.contains(user.id!)) {
            let i1 = event.interestedUserIds.index(of: user.id!)
            let i2 = user.interestedEventIds.index(of: event.id!)
            event.interestedUserIds.remove(at: i1!)
            user.interestedEventIds.remove(at: i2!)
            FirebaseAPIClient.favoriteEvent(event: event, user: user)
            interestedButton.setTitle("Interested?", for: .normal)
        } else {
            event.interestedUserIds.append(user.id!)
            user.interestedEventIds.append(event.id!)
            FirebaseAPIClient.favoriteEvent(event: event, user: user)
            interestedButton.setTitle("I'm Interested!", for: .normal)
        }
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
