//
//  ForgotPasswordViewController.swift
//  Firebase-boilerplate
//
//  Created by Mariano Montori on 7/25/17.
//  Copyright © 2017 Mariano Montori. All rights reserved.
//

import UIKit

class ForgotPasswordViewController: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func resetPasswordClicked(_ sender: UIButton) {
        guard let email = emailTextField.text,
            !email.isEmpty else {
            return
        }
        AuthService.passwordReset(email: email)
    }
}

extension ForgotPasswordViewController{
    func configureView(){
        applyKeyboardPush()
        applyKeyboardDismisser()
    }
}
