//
//  LoginViewController.swift
//
//  Created by Mariano Montori on 7/24/17.
//  Copyright © 2017 Mariano Montori. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase

class LoginViewController: UIViewController {
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func loginClicked(_ sender: UIButton) {
        guard let email = emailTextField.text,
            let password = passwordTextField.text else{
            return
        }
        Auth.auth().signIn(withEmail: email, password: password) { (user, error) in
            if let error = error {
                print("\(error.localizedDescription)")
                return
            }
            guard let user = user
                else { return }
            
            UserService.show(forUID: user.uid) { (user) in
                if let user = user {
                    User.setCurrent(user, writeToUserDefaults: true)
                }
                else {
                    print("no user exists!")
                }
            }
        }
    }
    
    @IBAction func createAccountClicked(_ sender: UIButton) {
        performSegue(withIdentifier: "createUser", sender: self)
    }
}
