//
//  SignUpViewController.swift
//  MDB Socials
//
//  Created by Mudabbir Khan on 2/22/18.
//  Copyright © 2018 MHK. All rights reserved.
//

import UIKit

class SignUpViewController: UIViewController {
    
    var emailTextField: UITextField!
    var passwordTextField: UITextField!
    var fullnameTextField: UITextField!
    var usernameTextField: UITextField!
    var signupButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTextFields()
        setupButton()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setupNavBar()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func setupNavBar() {
        navigationItem.title = "Sign Up"
        navigationController?.navigationBar.barTintColor = UIColor(displayP3Red: 0.40, green: 0.70, blue: 1.0, alpha: 0.7)
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor: UIColor.white, NSAttributedStringKey.font: UIFont(name: "AmericanTypewriter-Bold", size: 20)!]
    }
    
    func setupTextFields() {
        emailTextField = UITextField(frame: CGRect(x: 30, y: 100, width: view.frame.width - 60, height: 60))
        emailTextField.adjustsFontSizeToFitWidth = true
        emailTextField.placeholder = "Email"
        emailTextField.layoutIfNeeded()
        emailTextField.layer.borderColor = UIColor.black.cgColor
        emailTextField.layer.borderWidth = 1.0
        emailTextField.layer.masksToBounds = true
        emailTextField.layer.cornerRadius = 5
        emailTextField.textColor = UIColor.black
        view.addSubview(emailTextField)
        
        passwordTextField = UITextField(frame: CGRect(x: 30, y: 430, width: view.frame.width - 60, height: 60))
        passwordTextField.adjustsFontSizeToFitWidth = true
        passwordTextField.placeholder = "Password"
        passwordTextField.layer.borderColor = UIColor.black.cgColor
        passwordTextField.layer.borderWidth = 1.0
        passwordTextField.layer.masksToBounds = true
        passwordTextField.layer.cornerRadius = 5
        passwordTextField.textColor = UIColor.black
        passwordTextField.isSecureTextEntry = true
        view.addSubview(passwordTextField)
        
        fullnameTextField = UITextField(frame: CGRect(x: 30, y: 210, width: view.frame.width - 60, height: 60))
        fullnameTextField.adjustsFontSizeToFitWidth = true
        fullnameTextField.placeholder = "Full Name"
        fullnameTextField.layoutIfNeeded()
        fullnameTextField.layer.borderColor = UIColor.black.cgColor
        fullnameTextField.layer.borderWidth = 1.0
        fullnameTextField.layer.masksToBounds = true
        fullnameTextField.layer.cornerRadius = 5
        fullnameTextField.textColor = UIColor.black
        view.addSubview(fullnameTextField)
        
        usernameTextField = UITextField(frame: CGRect(x: 30, y: 320, width: view.frame.width - 60, height: 60))
        usernameTextField.adjustsFontSizeToFitWidth = true
        usernameTextField.placeholder = "Username"
        usernameTextField.layoutIfNeeded()
        usernameTextField.layer.borderColor = UIColor.black.cgColor
        usernameTextField.layer.borderWidth = 1.0
        usernameTextField.layer.masksToBounds = true
        usernameTextField.layer.cornerRadius = 5
        usernameTextField.textColor = UIColor.black
        view.addSubview(usernameTextField)
    }
    
    func setupButton() {
        signupButton = UIButton(frame: CGRect(x: 70, y: 540, width: view.frame.width - 140, height: 50))
        signupButton.backgroundColor = UIColor(displayP3Red: 0.20, green: 0.60, blue: 1.0, alpha: 1.0)
        signupButton.layoutIfNeeded()
        signupButton.setTitle("Sign Up", for: .normal)
        signupButton.setTitleColor(UIColor.white, for: .normal)
        signupButton.titleLabel?.font = UIFont(name: "AmericanTypewriter-Bold", size: 18)
        signupButton.layer.borderWidth = 2.0
        signupButton.layer.cornerRadius = 10.0
        signupButton.layer.borderColor = UIColor.black.cgColor
        signupButton.layer.masksToBounds = true
        signupButton.addTarget(self, action: #selector(signUpButtonClicked), for: .touchUpInside)
        self.view.addSubview(signupButton)
    }
    
    @objc func signUpButtonClicked() {
        if emailTextField.text == "" || passwordTextField.text == "" || fullnameTextField.text == "" || usernameTextField.text == "" {
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
            let email = emailTextField.text!
            let password = passwordTextField.text!
            let fullname = fullnameTextField.text!
            let username = usernameTextField.text!
            
            UserAuthHelper.createUser(email: email, password: password, withBlock: { (id) in
                FirebaseAPIClient.createNewUser(id: id, fullname: fullname, email: email, username: username)
                self.emailTextField.text = ""
                self.passwordTextField.text = ""
                self.fullnameTextField.text = ""
                self.usernameTextField.text = ""
                self.performSegue(withIdentifier: "toFeedFromSignup", sender: self)
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
