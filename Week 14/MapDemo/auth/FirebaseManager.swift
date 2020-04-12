//
//  FilebaseManager.swift
//  FirebaseLogin
//
//  Created by Anna Maria on 03/04/2020.
//  Copyright © 2020 Anna Maria. All rights reserved.
//

import Foundation
import FirebaseAuth

class FirebaseManager{
    
    var auth = Auth.auth() // Firebase's authentication class.
    let parentVC:LoginViewController
        
    init(parentVC:LoginViewController) {
            self.parentVC = parentVC
            auth.addIDTokenDidChangeListener { (auth, user) in
                if user != nil {
                    print("Status: user is logged in: \(user)") // show secret content
                    } else {
                    print("Status: user is logged out")
                    }
             }
        }
        
    func signUp(email:String, pwd:String) {
             auth.createUser(withEmail: email, password: pwd) { (result, error) in
                 if error == nil { // success
                    print("Successfully signed up \(result.debugDescription)")
                 } else {
                    print("Failed to create user \(error.debugDescription)")
                 }
             }
         }
         
    func signIn(email:String, pwd:String) {
             auth.signIn(withEmail: email, password: pwd) { (result, error) in
                 if error == nil { // success
                    print("Successfully logged in \(result.debugDescription)")
                    // call parentVC to display something, such as parentVC.showPanel()
                    // self.parentVC.presentMapVC()
                    } else {
                    print("Failed to log in \(error.debugDescription)")
                 }
             }
         }
         
    func signOut() {
            do {
                try auth.signOut()
                print("Successfully logged out")
                // self.parentVC.hideMapVC()// hide the secretVC here = show login screen again
                } catch let error {
                print("Error signing out \(error.localizedDescription)")

             }
    }
}
