//
//  LoginViewController.swift
//  MapDemo
//
//  Created by Anna Maria on 06/04/2020.
//  Copyright © 2020 Anna Maria. All rights reserved.
//

import UIKit
import FirebaseAuth


class LoginViewController: UIViewController {

    
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var emailField: UITextField!
    
    var firebaseManager:FirebaseManager?
    var auth = Auth.auth() // Firebase's authentication class.
    
    override func viewDidLoad() {
        super.viewDidLoad()
        firebaseManager = FirebaseManager(parentVC: self) // enable firebaseManager to update app's GUI
        firebaseManager?.signOut()
    }
    
    //func presentMapVC() {
    //    performSegue(withIdentifier: "mapSegue", sender: self)
    //  }
    //func hideMapVC() {
    //    performSegue(withIdentifier: "loginSegue", sender: self)
    //}
        
    @IBAction func singUpBtnPressed(_ sender: UIButton) {
        if verify().isOK {
            firebaseManager?.signUp(email: verify().email, pwd: verify().pwd)
        }
    }
        
    @IBAction func singInPressed(_ sender: UIButton) {
        if verify().isOK {
            firebaseManager?.signIn(email: verify().email, pwd: verify().pwd)
        }
    }

    func verify() -> (email:String, pwd:String, isOK:Bool) {  // returning multiple values is called "tuple"
        if let email = emailField.text, let pwd = passwordField.text { // verify if there is enough text
                          if email.count > 5 && pwd.count > 5{
                            return (email, pwd, true); // a tuple, containing 3 values
                          }
        }
        return ("", "", false)  // a tuple, containing 3 values
    }

}
