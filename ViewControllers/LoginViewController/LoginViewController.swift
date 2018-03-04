//
//  ViewController.swift
//  MDB Socials
//
//  Created by Mudabbir Khan on 2/21/18.
//  Copyright © 2018 MHK. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    
    var logo: UIImageView!
    var emailTextField: UITextField!
    var passwordTextField: UITextField!
    var loginButton: UIButton!
    var notMemberLabel: UILabel!
    var signUpLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        view.backgroundColor = UIColor(displayP3Red: 0.60, green: 0.80, blue: 1.0, alpha: 1.0)
        setupNavBar()
        setupTextFields()
        setupButton()
        setupNotMemberLabel()
        setupSignUp()
        setupLogo()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func setupNavBar() {
        navigationItem.title = "MDB Socials"
        navigationController?.navigationBar.barTintColor = UIColor(displayP3Red: 0.20, green: 0.60, blue: 1.0, alpha: 1.0)
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor: UIColor.white, NSAttributedStringKey.font: UIFont(name: "AmericanTypewriter-Bold", size: 20)!]
    }
    
    func setupTextFields() {
        emailTextField = UITextField(frame: CGRect(x: 30, y: 350, width: view.frame.width - 60, height: 40))
        emailTextField.adjustsFontSizeToFitWidth = true
        emailTextField.placeholder = "Email"
        emailTextField.layoutIfNeeded()
        emailTextField.layer.borderColor = UIColor.black.cgColor
        emailTextField.layer.borderWidth = 1.0
        emailTextField.layer.masksToBounds = true
        emailTextField.layer.cornerRadius = 5
        emailTextField.textColor = UIColor.black
        view.addSubview(emailTextField)
        
        passwordTextField = UITextField(frame: CGRect(x: 30, y: 410, width: view.frame.width - 60, height: 40))
        passwordTextField.adjustsFontSizeToFitWidth = true
        passwordTextField.placeholder = "Password"
        passwordTextField.layer.borderColor = UIColor.black.cgColor
        passwordTextField.layer.borderWidth = 1.0
        passwordTextField.layer.masksToBounds = true
        passwordTextField.layer.cornerRadius = 5
        passwordTextField.textColor = UIColor.black
        passwordTextField.isSecureTextEntry = true
        view.addSubview(passwordTextField)
    }
    
    func setupButton() {
        loginButton = UIButton(frame: CGRect(x: 70, y: 470, width: view.frame.width - 140, height: 50))
        loginButton.backgroundColor = UIColor(displayP3Red: 0.20, green: 0.60, blue: 1.0, alpha: 1.0)
        loginButton.layoutIfNeeded()
        loginButton.setTitle("Log In", for: .normal)
        loginButton.setTitleColor(UIColor.white, for: .normal)
        loginButton.titleLabel?.font = UIFont(name: "AmericanTypewriter-Bold", size: 18)
        loginButton.layer.borderWidth = 2.0
        loginButton.layer.cornerRadius = 10.0
        loginButton.layer.borderColor = UIColor.black.cgColor
        loginButton.layer.masksToBounds = true
        loginButton.addTarget(self, action: #selector(loginButtonClicked), for: .touchUpInside)
        self.view.addSubview(loginButton)
    }
    
    func setupLogo() {
        logo = UIImageView(frame: CGRect(x: 60, y: 100, width: view.frame.width - 120, height: 200))
        logo.image = UIImage(named: "mdblogo")
        logo.contentMode = .scaleAspectFit
        logo.clipsToBounds = true
        view.addSubview(logo)
    }
    
    func setupNotMemberLabel() {
        notMemberLabel = UILabel(frame: CGRect(x: 40, y: 580, width: view.frame.width - 180, height: 30))
        notMemberLabel.font = UIFont(name: "AppleSDGothicNeo-SemiBold", size: 18)
        notMemberLabel.textColor = .black
        notMemberLabel.textAlignment = .center
        notMemberLabel.text = "Not a member yet?"
        view.addSubview(notMemberLabel)
    }
    
    func setupSignUp() {
        signUpLabel = UILabel(frame: CGRect(x: 215, y: 580, width: view.frame.width - 300, height: 30))
        signUpLabel.font = UIFont(name: "AppleSDGothicNeo-SemiBold", size: 18)
        signUpLabel.textColor = .white
        signUpLabel.textAlignment = .center
        signUpLabel.text = "Sign Up!"
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(signUpTapped))
        signUpLabel.isUserInteractionEnabled = true
        signUpLabel.addGestureRecognizer(tapGesture)
        view.addSubview(signUpLabel)
    }
    
    @objc func signUpTapped(sender: UITapGestureRecognizer) {
        guard let a = (sender.view as? UILabel)?.text else { return }
        performSegue(withIdentifier: "toSignup", sender: self)
    }
    
    @objc func loginButtonClicked() {
        if emailTextField.text == "" || passwordTextField.text == "" {
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
            emailTextField.text = ""
            passwordTextField.text = ""
            UserAuthHelper.logIn(email: email, password: password, withBlock: {(user) in
                self.performSegue(withIdentifier: "toFeedFromLogin", sender: self)
            })
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toSignup" {
            _ = segue.destination as! SignUpViewController
            let backItem = UIBarButtonItem()
            backItem.title = "Cancel"
            navigationItem.backBarButtonItem = backItem
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

