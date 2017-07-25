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
    static func signIn(controller : UIViewController, email: String, password: String, completion: @escaping (FIRUser?) -> Void){
        Auth.auth().signIn(withEmail: email, password: password) { (user, error) in
            if let error = error {
                loginErrors(error: error, controller: controller)
                return completion(nil)
            }
            return completion(user)
        }
    }
    
    // Creates an authenticated user on Firebase
    static func createUser(controller : UIViewController, email: String, password: String, completion: @escaping (FIRUser?) -> Void){
        Auth.auth().createUser(withEmail: email, password: password) { (user, error) in
            if let error = error {
                signUpErrors(error: error, controller: controller)
                return completion(nil)
            }
            
            return completion(Auth.auth().currentUser)
        }
    }
    
    // Allows you to reset password for an email
    static func passwordReset(email: String){
        Auth.auth().sendPasswordReset(withEmail: email) { error in
            if let error = error {
                print("email error for: \(email)")
                print("error: \(error.localizedDescription)")
                return
            }
        }
    }
    
    /*
    ================= NOTE ====================
    Allows you to delete an authenticated user.
    Keep in mind you must also handle and 
    delete any database/storage that the user 
    uses. This only removes the user from 
    Firebase's Authentication.
    ===========================================
    */
    
    static func presentDelete(viewController : UIViewController, user : FIRUser){
        let alertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        let signOutAction = UIAlertAction(title: "Delete Account", style: .destructive) { _ in
            deleteAccount(user: user)
        }
        
        alertController.addAction(signOutAction)
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alertController.addAction(cancelAction)
        
        viewController.present(alertController, animated: true)
    }
    
    static func deleteAccount(user : FIRUser){
        UserService.deleteUser(forUID: User.current.uid, success: { (success) in
            if success {
                logUserOut()
                user.delete { error in
                    if let error = error {
                        print("DELETE ERROR \(error.localizedDescription)")
                    }
                }
            }
        })
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
        
        let signOutAction = UIAlertAction(title: "Log Out", style: .destructive) { _ in
            logUserOut()
        }
        
        alertController.addAction(signOutAction)
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alertController.addAction(cancelAction)
        
        viewController.present(alertController, animated: true)
    }
    
    static func logUserOut(){
        do {
            try Auth.auth().signOut()
        } catch let error as NSError {
            assertionFailure("Error signing out: \(error.localizedDescription)")
        }
    }
    
    private static func loginErrors(error : Error, controller : UIViewController){
        switch (error.localizedDescription) {
        case "The email address is badly formatted.":
            let invalidEmailAlert = UIAlertController(title: "Invalid Email", message:
                "It seems like you have put in an invalid email.", preferredStyle: UIAlertControllerStyle.alert)
            invalidEmailAlert.addAction(UIAlertAction(title: "Okay", style: UIAlertActionStyle.default,handler: nil))
            controller.present(invalidEmailAlert, animated: true, completion: nil)
            break;
        case "The password is invalid or the user does not have a password.":
            let wrongPasswordAlert = UIAlertController(title: "Wrong Password", message:
                "It seems like you have entered the wrong password.", preferredStyle: UIAlertControllerStyle.alert)
            wrongPasswordAlert.addAction(UIAlertAction(title: "Okay", style: UIAlertActionStyle.default,handler: nil))
            controller.present(wrongPasswordAlert, animated: true, completion: nil)
            break;
        case "There is no user record corresponding to this identifier. The user may have been deleted.":
            let wrongPasswordAlert = UIAlertController(title: "No Account Found", message:
                "We couldn't find an account that corresponds to that email. Do you want to create an account?", preferredStyle: UIAlertControllerStyle.alert)
            wrongPasswordAlert.addAction(UIAlertAction(title: "Okay", style: UIAlertActionStyle.default,handler: nil))
            controller.present(wrongPasswordAlert, animated: true, completion: nil)
            break;
        default:
            let loginFailedAlert = UIAlertController(title: "Error Logging In", message:
                "There was an error logging you in. Please try again soon.", preferredStyle: UIAlertControllerStyle.alert)
            loginFailedAlert.addAction(UIAlertAction(title: "Okay", style: UIAlertActionStyle.default,handler: nil))
            controller.present(loginFailedAlert, animated: true, completion: nil)
            break;
        }
    }
    
    private static func signUpErrors(error: Error, controller: UIViewController) {
        switch(error.localizedDescription) {
        case "The email address is badly formatted.":
            let invalidEmail = UIAlertController(title: "Email is not properly formatted.", message:
                "Please enter a valid email to sign up with..", preferredStyle: UIAlertControllerStyle.alert)
            invalidEmail.addAction(UIAlertAction(title: "Okay", style: UIAlertActionStyle.default,handler: nil))
            controller.present(invalidEmail, animated: true, completion: nil)
            break;
        default:
            let generalErrorAlert = UIAlertController(title: "We are having trouble signing you up.", message:
                "We are having trouble signing you up, please try again soon.", preferredStyle: UIAlertControllerStyle.alert)
            generalErrorAlert.addAction(UIAlertAction(title: "Okay", style: UIAlertActionStyle.default,handler: nil))
            controller.present(generalErrorAlert, animated: true, completion: nil)
            break;
        }
    }
}
