//
//  CreateAccountVC.swift
//  GroupApp
//
//  Created by Damonique Thomas on 11/17/16.
//  Copyright © 2016 Damonique Thomas. All rights reserved.
//

import UIKit
import Firebase

class CreateAccountVC: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var reenterPassTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func createAccount(_ sender: UIButton) {
        guard let email = emailTextField.text, let password = passwordTextField.text, let reenter = reenterPassTextField.text else {
            return
        }
        if password != reenter {
            displayAlert(message: "Passwords do not match")
            return
        }
        
        FIRAuth.auth()?.createUser(withEmail: email, password: password) { (user, error) in
            if let error = error {
                self.displayAlert(message: error.localizedDescription)
                print("Creating Account error - \(error.localizedDescription)")
                return
            }
            print("Create user successful")
            FIRAuth.auth()?.signIn(withEmail: email, password: password) { (user, error) in
                if let error = error {
                    print("Auth new account error - \(error.localizedDescription)")
                    return
                }
                if let user = user {
                    UserDefaults.standard.setValue(user.uid, forKey: "uid")
                    print("Log in successful")
                    self.addUserToDB(user: user)
                    self.performSegue(withIdentifier: "accountCreatedSegue", sender: nil)
                }
            }
        }
        
    }
    
    private func addUserToDB(user: FIRUser){
        
    }
    
    private func displayAlert(message: String){
        let alertView = UIAlertController(title: "Uh-Oh", message: message, preferredStyle: .alert)
        alertView.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        present(alertView, animated: true, completion: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "accountCreatedSegue" {
            //let controller = segue.destinationViewController as! ShowDetailViewController
            //let show = sender as! TVShowDetail
            //controller.show = show
        }
    }
}