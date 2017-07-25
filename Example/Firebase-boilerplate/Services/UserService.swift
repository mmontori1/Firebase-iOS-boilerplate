//
//  UserService.swift
//
//  Created by Mariano Montori on 7/24/17.
//  Copyright © 2017 Mariano Montori. All rights reserved.
//

import Foundation
import FirebaseDatabase

struct UserService {
    static func create(_ firUser: FIRUser, username: String, firstName: String, lastName: String, completion: @escaping (User?) -> Void) {
        let userAttrs = ["username": username,
                         "firstName": firstName,
                         "lastName": lastName]
        
        let ref = Database.database().reference().child("users").child(firUser.uid)
        ref.setValue(userAttrs) { (error, ref) in
            if let error = error {
                assertionFailure(error.localizedDescription)
                return completion(nil)
            }
            
            ref.observeSingleEvent(of: .value, with: { (snapshot) in
                let user = User(snapshot: snapshot)
                completion(user)
            })
        }
    }
    
    static func show(forUID uid: String, completion: @escaping (User?) -> Void) {
        let ref = Database.database().reference().child("users").child(uid)
        ref.observeSingleEvent(of: .value, with: { (snapshot) in
            guard let user = User(snapshot: snapshot) else {
                return completion(nil)
            }
            
            completion(user)
        })
    }
    
    static func deleteUser(forUID uid: String, success: @escaping (Bool) -> Void) {
        let ref = Database.database().reference().child("users")
        let object = [uid : NSNull()]
        ref.updateChildValues(object) { (error, ref) -> Void in
            if let error = error {
                print("error : \(error.localizedDescription)")
                return success(false)
            }
            return success(true)
        }
        
    }
}
