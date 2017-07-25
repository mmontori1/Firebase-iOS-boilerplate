//
//  AuthService.swift
//  
//  Created by Mariano Montori on 7/24/17.
//  Copyright © 2017 Mariano Montori. All rights reserved.
//

import UIKit
import FirebaseAuth

struct AuthService {
    
    // Signs in as an authenticated user on Firebase
    static func signIn(email: String, password: String, completion: @escaping (FIRUser?) -> Void){
        Auth.auth().signIn(withEmail: email, password: password) { (user, error) in
            if let error = error {
                print("\(error.localizedDescription)")
                return completion(nil)
            }
            return completion(user)
        }
    }
    
    // Creates an authenticated user on Firebase
    static func createUser(email: String, password: String, completion: @escaping (FIRUser?) -> Void){
        Auth.auth().createUser(withEmail: email, password: password) { (user, error) in
            if let error = error {
                print("\(error.localizedDescription)")
                return completion(nil)
            }
            
            return completion(Auth.auth().currentUser)
        }
    }
    
    /*
    ================= NOTE ====================
    This allows the user to return back to the
    login screen (storyboard) when the user has
    logged out.
    ===========================================
    */
    static func authListener(viewController view : UIViewController) -> AuthStateDidChangeListenerHandle {
        let authHandle = Auth.auth().addStateDidChangeListener() { (auth, user) in
            guard user == nil else { return }
            
            let loginViewController = UIStoryboard.initialViewController(for: .login)
            view.view.window?.rootViewController = loginViewController
            view.view.window?.makeKeyAndVisible()
        }
        return authHandle
    }
    
    /*
    ================= NOTE ====================
    Use this when you have confirmed the user 
    has logged out. Make sure to use this with
    authListener.
    ===========================================
    */
    static func removeAuthListener(authHandle : AuthStateDidChangeListenerHandle?){
        if let authHandle = authHandle {
            Auth.auth().removeStateDidChangeListener(authHandle)
        }
    }
    
    /*
    ====================== WARNING ==========================
    Only use this function where you create the AuthListener!
    It can cause problems otherwise since the listener might
    not be removed. You can also make sure that the listener
    is removed.
    =========================================================
    */
    static func presentLogOut(viewController : UIViewController){
        let alertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        let signOutAction = UIAlertAction(title: "Are you sure you want to log out?", style: .destructive) { _ in
            do {
                try Auth.auth().signOut()
            } catch let error as NSError {
                assertionFailure("Error signing out: \(error.localizedDescription)")
            }
        }
        
        alertController.addAction(signOutAction)
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alertController.addAction(cancelAction)
        
        viewController.present(alertController, animated: true)
    }
}
