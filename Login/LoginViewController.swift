//
//  LoginViewController.swift
//  Login
//
//  Created by Paige Plander on 4/5/17.
//  Copyright © 2017 Paige Plander. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    
    // Constants used in the LoginViewController
    struct Constants {
        static let backgroundColor: UIColor = UIColor(hue: 0.5389, saturation: 1, brightness: 0.92, alpha: 1.0)
        static let invalidEmailTitle = "Invalid username or password"
        static let invalidEmailMessage = "Please try again"
        static let buttonCornerRadius: CGFloat = 10
    }

    // TODO: instantiate the views needed for your project
    
    var email: String = ""
    var password: String = ""
    
    var button: UIButton = {
        let myButton = UIButton()
        let fontSize: CGFloat = 24
        let textColor: UIColor = UIColor.white

        // configure the button
        myButton.setTitle("LOGIN", for: .normal)
        myButton.titleLabel?.font = UIFont.systemFont(ofSize: fontSize)
        myButton.titleLabel?.numberOfLines = 1
        myButton.titleLabel?.textAlignment = .center
        myButton.setTitleColor(textColor, for: .normal)
        myButton.backgroundColor = Constants.backgroundColor
        myButton.layer.cornerRadius = Constants.buttonCornerRadius
        myButton.layer.masksToBounds = true
        
        return myButton
    }()
    
    var mainLabel: UILabel = {
        let mainLabel = UILabel()
        let fontSize: CGFloat = 45
        
        mainLabel.text = "Login View Controller"
        mainLabel.font = UIFont.systemFont(ofSize: fontSize)
        mainLabel.numberOfLines = 2
        mainLabel.textAlignment = .center
        mainLabel.textColor = UIColor.white
        
        return mainLabel
    }()
    
    var emailTextField: UITextField = {
        let emailTextField = UITextField()
        
        emailTextField.placeholder = "berkeley.edu account"
        emailTextField.autocapitalizationType = UITextAutocapitalizationType.none
        
        return emailTextField
    }()
    
    var passwordTextField: UITextField = {
        let passwordTextField = UITextField()
        
        passwordTextField.placeholder = "password"
        
        return passwordTextField
    }()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = Constants.backgroundColor
        
        mainLabel.frame = CGRect(x: view.frame.width * 0.5 - 150, y: 30, width: 300, height: 200)
        view.addSubview(mainLabel)
        
        let mySubview: UIView = UIView()
        mySubview.frame = CGRect(x: 100, y: 100, width: view.frame.width * 0.9, height: 200)
        mySubview.layer.cornerRadius = Constants.buttonCornerRadius
        mySubview.backgroundColor = UIColor.white
        mySubview.center = view.center
        view.addSubview(mySubview)
        
        button.frame = CGRect(x: mySubview.frame.width * 0.5 - 50, y: mySubview.frame.height * 0.7, width: 100, height: 40)
        button.addTarget(self, action: #selector(loginButtonPressed), for: .touchDown)
        mySubview.addSubview(button)
        
        emailTextField.frame = CGRect(x: mySubview.frame.width * 0.5 - 150, y: mySubview.frame.height * 0.1, width: 300, height:40)
        mySubview.addSubview(emailTextField)
        
        passwordTextField.frame = CGRect(x: mySubview.frame.width * 0.5 - 150, y: mySubview.frame.height * 0.4, width: 300, height:40)
        mySubview.addSubview(passwordTextField)
        
        //contraints
        mainLabel.topAnchor.constraint(equalTo: view.topAnchor)
        mainLabel.addConstraint(NSLayoutConstraint(item: mainLabel, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 200))
        mainLabel.addConstraint(NSLayoutConstraint(item: mainLabel, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 300))
        let verticalSpace = NSLayoutConstraint(item: mainLabel, attribute: .bottom, relatedBy: .equal, toItem: mySubview, attribute: .top, multiplier: 1, constant: -50)
        NSLayoutConstraint.activate([verticalSpace])
        
    }
    
    // TODO: create an IBAction for your login button
    @IBAction func loginButtonPressed(sender: UIButton)  {
        if let email = emailTextField.text, let password = passwordTextField.text {
            authenticateUser(username: email, password: password)
        }
    }
    
    /// YOU DO NOT NEED TO MODIFY ANY OF THE CODE BELOW (but you will want to use `authenticateUser` at some point)
    
    // Model class to handle checking if username/password combinations are valid.
    // Usernames and passwords can be found in the Lab6Names.csv file
    let loginModel = LoginModel(filename: "Lab6Names")

    /// Imageview for login success image (do not need to modify)
    let loginSuccessView = UIImageView(image: UIImage(named: "oski"))
    
    /// If the provided username/password combination is valid, displays an
    /// image (in the "loginSuccessView" imageview). If invalid, displays an alert
    /// telling the user that the login was unsucessful.
    /// You do not need to edit this function, but you will want to use it for the lab.
    ///
    /// - Parameters:
    ///   - username: the user's berkeley.edu address
    ///   - password: the user's first name (what a great password!)
    func authenticateUser(username: String?, password: String?) {
        
        // if username / password combination is invalid, present an alert
        if !loginModel.authenticate(username: username, password: password) {
            loginSuccessView.isHidden = true
            let alert = UIAlertController(title: Constants.invalidEmailTitle, message: Constants.invalidEmailMessage, preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
            
        // If username / password combination is valid, display success image
        else {
            if !loginSuccessView.isDescendant(of: view) {
                view.addSubview(loginSuccessView)
                loginSuccessView.contentMode = .scaleAspectFill
            }
            
            loginSuccessView.isHidden = false
            
            // Constraints for the login success view
            loginSuccessView.translatesAutoresizingMaskIntoConstraints = false
            loginSuccessView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
            loginSuccessView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
            loginSuccessView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
            loginSuccessView.heightAnchor.constraint(equalToConstant: view.frame.height/4).isActive = true
        }
    }
}
