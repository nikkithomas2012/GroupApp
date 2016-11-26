//
//  NewGroupVC.swift
//  GroupApp
//
//  Created by Damonique Thomas on 11/18/16.
//  Copyright © 2016 Damonique Thomas. All rights reserved.
//

import UIKit
import Firebase

class NewGroupVC: UIViewController {
    
    @IBOutlet weak var grpNameTextField: UITextField!
    let rootRef = FIRDatabase.database().reference()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func createNewGroup(_ sender: UIButton) {
        guard let groupName = grpNameTextField.text else {
            return
        }
        
        //Add new group and add users membership
        let uid =  UserDefaults.standard.object(forKey:"uid") as! String
        let pushRef = rootRef.child("groups").childByAutoId()
        let pushId = pushRef.key
        
        var newGroup = Group(name: groupName)
        newGroup.addMember(uid: uid)
        pushRef.setValue(newGroup.toAnyObject())
        let userRef = rootRef.child("users").child(uid).child("groups")
        userRef.updateChildValues([pushId:true])
        
        self.navigationController?.popViewController(animated: true)
    }


}
