//
//  NewEventViewController.swift
//  MDB Socials
//
//  Created by Mudabbir Khan on 3/3/18.
//  Copyright © 2018 MHK. All rights reserved.
//

import UIKit
import Firebase

class NewEventViewController: UIViewController {
    
    var eventTitleTextField: UITextField!
    var descriptionTextField: UITextField!
    var newEventButton: UIButton!
    var eventImageView: UIImageView!
    var choosePhotoLabel: UILabel!
    var date: String!
    var user: Users!
    var event: Event!
    var vc = FeedViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Users.getCurrentUser(withId: (Auth.auth().currentUser?.uid)!, block: {(cUser) in
            self.user = cUser
        })
        setupNavBar()
        setupPhoto()
        setupTextFields()
        setupButton()
        let datePicker: UIDatePicker = UIDatePicker()
        view.addSubview(datePicker)
        datePicker.frame = CGRect(x: 10, y: 480, width: self.view.frame.width, height: 100)
        
        
        // Set some of UIDatePicker properties
        datePicker.backgroundColor = UIColor.white
        
        // Add an event to call onDidChangeDate function when value is changed.
        datePicker.addTarget(self, action: #selector(datePickerValueChanged(_:)), for: .valueChanged)
        
        // Add DataPicker to the view
        self.view.addSubview(datePicker)

        // Do any additional setup after loading the view.
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func setupNavBar() {
        navigationItem.title = "New Event"
//        let addEventButton = UIBarButtonItem(title: "Create", style: .plain, target: self, action: #selector(createTapped))
//        navigationItem.rightBarButtonItem = addEventButton
//        navigationItem.rightBarButtonItem?.tintColor = .white
    }
    
//    func createTapped() {
//
//    }
    
    func setupPhoto() {
        eventImageView = UIImageView(frame: CGRect(x: 80, y: 90, width: view.frame.width - 160, height: 130))
        eventImageView.layoutIfNeeded()
        eventImageView.layer.borderWidth = 1.0
        eventImageView.layer.borderColor = UIColor.black.cgColor
        eventImageView.layer.masksToBounds = true
        eventImageView.layer.cornerRadius = 5
        view.addSubview(eventImageView)
        
        choosePhotoLabel = UILabel(frame: CGRect(x: 130, y: 250, width: view.frame.width - 250, height: 30))
        choosePhotoLabel.font = UIFont(name: "AppleSDGothicNeo-SemiBold", size: 18)
        choosePhotoLabel.textColor = .black
        choosePhotoLabel.textAlignment = .center
        choosePhotoLabel.text = "Choose Photo"
        choosePhotoLabel.sizeToFit()
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(choosePhotoTapped))
        choosePhotoLabel.isUserInteractionEnabled = true
        choosePhotoLabel.addGestureRecognizer(tapGesture)
        view.addSubview(choosePhotoLabel)
    }
    
    @objc func choosePhotoTapped(sender: UITapGestureRecognizer) {
        guard let a = (sender.view as? UILabel)?.text else { return }
        PhotoHandler.shared.showActionSheet(vc: self)
        PhotoHandler.shared.imagePickedBlock = { (image) in
            /* get your image here */
            self.eventImageView.image = image
            self.eventImageView.contentMode = .scaleAspectFill
        }
    }
    
    func setupTextFields() {
        eventTitleTextField = UITextField(frame: CGRect(x: 30, y: 300, width: view.frame.width - 60, height: 40))
        eventTitleTextField.adjustsFontSizeToFitWidth = true
        eventTitleTextField.placeholder = "Title"
        eventTitleTextField.layoutIfNeeded()
        eventTitleTextField.layer.borderColor = UIColor.black.cgColor
        eventTitleTextField.layer.borderWidth = 1.0
        eventTitleTextField.layer.masksToBounds = true
        eventTitleTextField.layer.cornerRadius = 5
        eventTitleTextField.textColor = UIColor.black
        view.addSubview(eventTitleTextField)
        
        descriptionTextField = UITextField(frame: CGRect(x: 30, y: 370, width: view.frame.width - 60, height: 100))
        descriptionTextField.adjustsFontSizeToFitWidth = true
        descriptionTextField.placeholder = "Description"
        descriptionTextField.layoutIfNeeded()
        descriptionTextField.layer.borderColor = UIColor.black.cgColor
        descriptionTextField.layer.borderWidth = 1.0
        descriptionTextField.layer.masksToBounds = true
        descriptionTextField.layer.cornerRadius = 5
        descriptionTextField.textColor = UIColor.black
        view.addSubview(descriptionTextField)
    }
    
    @objc func datePickerValueChanged(_ sender: UIDatePicker){
        
        let dateFormatter: DateFormatter = DateFormatter()
        
        // Set date format
        dateFormatter.dateFormat = "E, d MMM yyyy HH:mm:ss"
        
        // Apply date format
        date = dateFormatter.string(from: sender.date)
    }
    
    func setupButton() {
        newEventButton = UIButton(frame: CGRect(x: 70, y: 580, width: view.frame.width - 140, height: 50))
        newEventButton.backgroundColor = UIColor(displayP3Red: 0.20, green: 0.60, blue: 1.0, alpha: 1.0)
        newEventButton.layoutIfNeeded()
        newEventButton.setTitle("Create", for: .normal)
        newEventButton.setTitleColor(UIColor.white, for: .normal)
        newEventButton.titleLabel?.font = UIFont(name: "AmericanTypewriter-Bold", size: 18)
        newEventButton.layer.borderWidth = 2.0
        newEventButton.layer.cornerRadius = 10.0
        newEventButton.layer.borderColor = UIColor.black.cgColor
        newEventButton.layer.masksToBounds = true
        newEventButton.addTarget(self, action: #selector(newEventButtonClicked), for: .touchUpInside)
        self.view.addSubview(newEventButton)
    }
    
    @objc func newEventButtonClicked() {
        if eventTitleTextField.text == "" || descriptionTextField.text == "" {
            let alert = UIAlertController(title: "Missing Fields!", message: "Please fill out all fields.", preferredStyle: UIAlertControllerStyle.alert)
            self.present(alert, animated: true, completion: nil)
            alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { action in
                switch action.style{
                case.default:
                    print("default")
                    
                case.cancel:
                    print("cancel")
                    
                case.destructive:
                    print("destructive")
                }
            }))
        } else {
            let eventImageData = UIImageJPEGRepresentation(eventImageView.image!, 0.9)
            let title = eventTitleTextField.text!
            let description = descriptionTextField.text!
            
            FirebaseAPIClient.createNewEvent(imageData: eventImageData!, withBlock: { (imageURL, id) in
                FirebaseAPIClient.createEvent(id: id, title: title, creator: self.user.fullname!, creatorId: self.user.id!, description: description, date: self.date, imageURL: imageURL)
                self.event = Event(id: id, postDict: ["title": title, "creator": self.user.fullname!, "creatorId": self.user.id!, "description": description, "date": self.date, "imageURL": imageURL])
                self.vc.newEvent(event: self.event)
                self.eventTitleTextField.text = ""
                self.descriptionTextField.text = ""
                self.navigationController?.popViewController(animated: true)
            })
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
