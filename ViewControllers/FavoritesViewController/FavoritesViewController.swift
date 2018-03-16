//
//  FavoritesViewController.swift
//  MDB Socials
//
//  Created by Mudabbir Khan on 3/13/18.
//  Copyright © 2018 MHK. All rights reserved.
//

import UIKit
import Firebase

class FavoritesViewController: UIViewController {
    
    var favoritesTableView: UITableView!
    var favorites: [Event] = []
    var event: Event!
    var auth = Auth.auth()
    var postsRef: DatabaseReference = Database.database().reference().child("Events")
    var storage: StorageReference = Storage.storage().reference()
    var currentUser: Users?
    var fav: [String] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Favorites"
        
        let activityIndicator = UIActivityIndicatorView(activityIndicatorStyle: .gray)
        activityIndicator.startAnimating()
        Users.getCurrentUser(withId: (Auth.auth().currentUser?.uid)!, block: {(cUser) in
            self.currentUser = cUser
            self.fav = (self.currentUser?.interestedEventIds)!
            
            FirebaseAPIClient.fetchFavorites(ids: self.fav, completion: { (events) in
                self.favorites.append(contentsOf: events)
                print("the contents of posts are now... \(self.favorites)")
                //            self.sortPosts()
                
                activityIndicator.stopAnimating()
                
            })
        })
        setupTableView()
        self.favoritesTableView.reloadData()
        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.favoritesTableView.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setupTableView() {
        favoritesTableView = UITableView(frame: view.frame)
        favoritesTableView.register(FavoritesTableViewCell.self, forCellReuseIdentifier: "favCell")
        favoritesTableView.backgroundColor = UIColor.white
        favoritesTableView.rowHeight = 250
        favoritesTableView.showsVerticalScrollIndicator = true
        favoritesTableView.bounces = true
        //        eventTableView.tag = 1
        favoritesTableView.delegate = self
        favoritesTableView.dataSource = self
        view.addSubview(favoritesTableView)
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

extension FavoritesViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favorites.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "favCell", for: indexPath) as! FavoritesTableViewCell
        
        cell.awakeFromNib()
        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let eventCell = cell as! FavoritesTableViewCell
        let event = favorites[indexPath.item]
        FirebaseAPIClient.fetchUser(id: event.creatorId!) { (user) in
            eventCell.createrUserName.text = user.username
            Utils.getImage(withUrl: user.imageURL!).then {image in
                eventCell.createrImage.image = image
            }
        }
        eventCell.eventTitle.text = event.title
        Utils.getImage(withUrl: event.imageURL!).then {image in
            eventCell.eventImage.image = image
        }
        eventCell.date.text = event.date!
        eventCell.interestedUserIds.text = "\(event.interestedUserIds.count) interested"
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        event = favorites[indexPath.row]
        CellTapped()
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 250
    }
    
    func CellTapped() {
        self.tabBarController?.performSegue(withIdentifier: "toDetailFromFeed", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
    }
}

extension FavoritesViewController: FavoritesTableViewCellDelegate {
    
    func tableButton(forCell: FavoritesTableViewCell) {
        forCell.backgroundColor = UIColor.clear
    }
}

