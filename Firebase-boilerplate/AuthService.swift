//
//  AuthService.swift
//  
//  Created by Mariano Montori on 7/24/17.
//  Copyright © 2017 Mariano Montori. All rights reserved.
//

import Foundation
import UIKit
import FirebaseAuth

struct AuthService {
    static func signIn(email: String, password: String, completion: @escaping (FIRUser?) -> Void){
        Auth.auth().signIn(withEmail: email, password: password) { (user, error) in
            if let error = error {
                print("\(error.localizedDescription)")
                return completion(nil)
            }
            return completion(user)
        }
    }
    
    static func createUser(email: String, password: String, completion: @escaping (FIRUser?) -> Void){
        Auth.auth().createUser(withEmail: email, password: password) { (user, error) in
            if let error = error {
                print("\(error.localizedDescription)")
                return completion(nil)
            }
            
            return completion(Auth.auth().currentUser)
        }
    }
}
