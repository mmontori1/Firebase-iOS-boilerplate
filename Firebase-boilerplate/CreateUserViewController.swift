//
//  CreateUserViewController.swift
//  Firebase-boilerplate
//
//  Created by Mariano Montori on 7/24/17.
//  Copyright © 2017 Mariano Montori. All rights reserved.
//

import UIKit
import FirebaseAuth

class CreateUserViewController: UIViewController {

    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    @IBAction func signUpClicked(_ sender: UIButton) {
        guard let email = emailTextField.text,
            let password = passwordTextField.text else{
                return
        }
        Auth.auth().createUser(withEmail: email, password: password) { (user, error) in
            if let error = error {
                print("\(error.localizedDescription)")
                return
            }
            guard let firUser = Auth.auth().currentUser,
                let username = self.usernameTextField.text,
                !username.isEmpty else { return }
            
            UserService.create(firUser, username: username) { (user) in
                guard let user = user else {
                    return
                }
                
                User.setCurrent(user, writeToUserDefaults: true)
            }
        }
        
    }
}
