//
//  ViewController.swift
//  GroupApp
//
//  Created by Damonique Thomas on 11/17/16.
//  Copyright © 2016 Damonique Thomas. All rights reserved.
//

import UIKit
import Firebase

class LoginVC: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        FIRAuth.auth()?.addStateDidChangeListener { auth, user in
            if user != nil {
                self.performSegue(withIdentifier: "loggedInSegue", sender: nil)
            }
        
        }
    }

    @IBAction func signIn(_ sender: UIButton) {
        guard let email = emailTextField.text, let password = passwordTextField.text else {
            displayAlert(message: "Enter an email and password")
            return
        }
        
        FIRAuth.auth()?.signIn(withEmail: email, password: password) { (user, error) in
            if let error = error {
                self.displayAlert(message: "Wrong email/password")
                print(error)
                return
            }
            if let user = user {
                UserDefaults.standard.setValue(user.uid, forKey: "uid")
                UserDefaults.standard.setValue(user.email, forKey: "email")
                self.performSegue(withIdentifier: "loggedInSegue", sender: nil)
            }
        }
        
    }
    
    private func displayAlert(message: String){
        let alertView = UIAlertController(title: "Uh-Oh", message: message, preferredStyle: .alert)
        alertView.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        present(alertView, animated: true, completion: nil)
    }

}

