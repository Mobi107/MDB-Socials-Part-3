//
//  TabBarController.swift
//  MDB Socials
//
//  Created by Mudabbir Khan on 3/13/18.
//  Copyright © 2018 MHK. All rights reserved.
//

import UIKit

class TabBarController: UITabBarController, UITabBarControllerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self
        self.navigationItem.setHidesBackButton(true, animated: true)
        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        let feedViewController = FeedViewController()
        feedViewController.tabBarItem = UITabBarItem(tabBarSystemItem: .more, tag: 0)
        let favoritesViewController = FavoritesViewController()
        favoritesViewController.tabBarItem = UITabBarItem(tabBarSystemItem: .favorites, tag: 1)
        let viewControllerList = [feedViewController, favoritesViewController]
        self.viewControllers = viewControllerList
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

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        navigationItem.title = viewController.title
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
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toDetailFromFeed" {
            let detail = segue.destination as! DetailViewController
            let currentVC = self.viewControllers![0] as! FeedViewController
            detail.event = currentVC.event
        } else if segue.identifier == "toNewEventFromFeed" {
            _ = segue.destination as! NewEventViewController
            //            newEvent.user = currentUser
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
