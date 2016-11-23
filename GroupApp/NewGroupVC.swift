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
        let uid = defaults.object(forKey:"uid") as! String
        let pushRef = rootRef.child("groups").push()
        let pushId = pushRef.getKey()
        
        let newGroup = Group(name: groupName)
        newGroup.addMember(uid)
        pushRef.setValue(newGroup.toAnyObject())
        let userRef = rootRef.child(uid).child("groups")
        userRef.setValue([pushId:true])
        
    }


}
