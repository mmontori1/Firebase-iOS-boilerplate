//
//  MainViewController.swift
//  Firebase-boilerplate
//
//  Created by Mariano Montori on 7/24/17.
//  Copyright © 2017 Mariano Montori. All rights reserved.
//

import UIKit
import FirebaseAuth

class MainViewController: UIViewController {

    var authHandle: AuthStateDidChangeListenerHandle?
    
    @IBOutlet weak var label: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        label.text = "\(User.current.username) \(User.current.firstName) \(User.current.lastName)"
        
        authHandle = AuthService.authListener(viewController: self)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    deinit {
        AuthService.removeAuthListener(authHandle: authHandle)
    }

    @IBAction func logOutClicked(_ sender: UIButton) {
        AuthService.presentLogOut(viewController: self)
    }
}
