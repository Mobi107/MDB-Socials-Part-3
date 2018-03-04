//
//  FeedViewController.swift
//  MDB Socials
//
//  Created by Mudabbir Khan on 2/22/18.
//  Copyright © 2018 MHK. All rights reserved.
//

import UIKit
import Firebase

class FeedViewController: UIViewController {
    
    var eventTableView: UITableView!
    var events: [Event] = []
    var event: Event!
    var auth = Auth.auth()
    var postsRef: DatabaseReference = Database.database().reference().child("Events")
    var storage: StorageReference = Storage.storage().reference()
    var currentUser: Users?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.setHidesBackButton(true, animated: true)
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        let activityIndicator = UIActivityIndicatorView(activityIndicatorStyle: .gray)
        activityIndicator.startAnimating()
        setupTableView()
        Users.getCurrentUser(withId: (Auth.auth().currentUser?.uid)!, block: {(cUser) in
            self.currentUser = cUser
        })
        FirebaseAPIClient.fetchEvents(withBlock: { (events) in
            self.events.append(contentsOf: events)
            print("the contents of posts are now... \(self.events)")
            self.eventTableView.reloadData()
            
            activityIndicator.stopAnimating()
            
        })
    }
    
    override func viewDidAppear(_ animated: Bool) {
        setupNavBar()
    }
    
    func setupNavBar() {
        navigationItem.title = "Feed"
        navigationController?.navigationBar.barTintColor = UIColor(displayP3Red: 0.40, green: 0.70, blue: 1.0, alpha: 0.7)
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor: UIColor.white, NSAttributedStringKey.font: UIFont(name: "AmericanTypewriter-Bold", size: 20)!]
        let logoutButton = UIBarButtonItem(title: "Log Out", style: .plain, target: self, action: #selector(logOut))
        navigationItem.leftBarButtonItem = logoutButton
        navigationItem.leftBarButtonItem?.tintColor = .white
        let addEventButton = UIBarButtonItem(title: "Create Event", style: .plain, target: self, action: #selector(createEventTapped))
        navigationItem.rightBarButtonItem = addEventButton
        navigationItem.rightBarButtonItem?.tintColor = .white
    }
    
    func setupTableView() {
        eventTableView = UITableView(frame: view.frame)
        eventTableView.register(FeedTableViewCell.self, forCellReuseIdentifier: "feedCell")
        eventTableView.backgroundColor = UIColor.white
        eventTableView.rowHeight = (view.frame.height / 2) - 32
        eventTableView.showsVerticalScrollIndicator = true
        eventTableView.bounces = true
//        eventTableView.tag = 1
        eventTableView.delegate = self
        eventTableView.dataSource = self
        view.addSubview(eventTableView)
    }
    
    @objc func logOut() {
        print("this thing was clicked on")
        UserAuthHelper.logOut {
            print("logged out")
            self.navigationController?.popViewController(animated: true)
        }
    }
    
    @objc func createEventTapped() {
        self.performSegue(withIdentifier: "toNewEventFromFeed", sender: self)
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
extension FeedViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return events.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "feedCell", for: indexPath) as! FeedTableViewCell
        for subview in cell.contentView.subviews {
            subview.removeFromSuperview()
        }
        cell.awakeFromNib()
        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let eventCell = cell as! FeedTableViewCell
        let event = events[indexPath.item]
        Users.getCurrentUser(withId: event.creatorId!) { (user) in
            eventCell.createrUserName.text = user.username
            user.getProfilePic {
                eventCell.createrImage.image = user.image
            }
        }
        eventCell.eventTitle.text = event.title
        event.getEventPic {
            eventCell.eventImage.image = event.image
        }
        eventCell.date.text = event.date
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        event = events[indexPath.row]
        CellTapped()
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func CellTapped() {
        self.performSegue(withIdentifier: "toDetailFromFeed", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toDetailFromFeed" {
            let detail = segue.destination as! DetailViewController
            detail.event = event
        } else if segue.identifier == "toNewEventFromFeed" {
            _ = segue.destination as! NewEventViewController
//            newEvent.user = currentUser
        }
    }
}

extension FeedViewController: FeedTableViewCellDelegate {
    
    func tableButton(forCell: FeedTableViewCell) {
        forCell.backgroundColor = UIColor.clear
    }
}
