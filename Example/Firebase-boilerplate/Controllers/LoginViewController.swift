//
//  LoginViewController.swift
//
//  Created by Mariano Montori on 7/24/17.
//  Copyright © 2017 Mariano Montori. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var logInButton: UIButton!
    @IBOutlet weak var createAccountButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let identifier = segue.identifier {
            if identifier == "createUser" {
                print("To Create User Screen!")
            }
            if identifier == "forgotPassword" {
                print("To Forget Password Screen!")
            }
        }
    }
    
    @IBAction func unwindToLogin(_ segue: UIStoryboardSegue) {
        print("Returned to Login Screen!")
    }
    
    @IBAction func loginClicked(_ sender: UIButton) {
        dismissKeyboard()
        guard let email = emailTextField.text,
            let password = passwordTextField.text else{
            return
        }
        AuthService.signIn(controller: self, email: email, password: password) { (user) in
            guard let user = user else {
                print("error: FIRUser does not exist!")
                return
            }
            
            UserService.show(forUID: user.uid) { (user) in
                if let user = user {
                    User.setCurrent(user, writeToUserDefaults: true)
                    let initialViewController = UIStoryboard.initialViewController(for: .main)
                    self.view.window?.rootViewController = initialViewController
                    self.view.window?.makeKeyAndVisible()
                }
                else {
                    print("error: User does not exist!")
                    return
                }
            }
        }
    }
    
    @IBAction func createAccountClicked(_ sender: UIButton) {
        dismissKeyboard()
        performSegue(withIdentifier: "createUser", sender: self)
    }
    
    @IBAction func forgotPasswordClicked(_ sender: UIButton) {
        dismissKeyboard()
        performSegue(withIdentifier: "forgotPassword", sender: self)
    }
}

extension LoginViewController{
    func configureView(){
        applyKeyboardPush()
        applyKeyboardDismisser()
        logInButton.layer.cornerRadius = 10
        createAccountButton.layer.cornerRadius = 10
    }
}
