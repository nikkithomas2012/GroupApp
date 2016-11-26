//
//  UsersTableVC.swift
//  GroupApp
//
//  Created by Damonique Thomas on 11/18/16.
//  Copyright © 2016 Damonique Thomas. All rights reserved.
//

import UIKit
import Firebase

class UsersTableVC: UITableViewController {
    
    @IBOutlet weak var noMembersLabel: UILabel!
    
    var userInGroup = false
    var group: Group!
    var members = [String]()
    
    let uid =  UserDefaults.standard.object(forKey:"uid") as! String
    let email = UserDefaults.standard.object(forKey:"email") as! String
    let rootRef = FIRDatabase.database().reference()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.isHidden = false
        tableView.delegate = self
        tableView.dataSource = self
        members = group.members
        isUserAMember()
        
        var buttonTitle = "Join Group"
        self.noMembersLabel.isHidden = true
        if userInGroup {
            buttonTitle = "Leave Group"
        }
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: buttonTitle, style: .plain, target: self, action: #selector(manageMembership))
        navigationItem.title = "\(group.name)"
        
        getMemberNames()
    }
    
    private func isUserAMember() {
        for member in members {
            if member == uid {
                userInGroup = true
                return
            }
        }
        userInGroup = false
    }
    
    private func getMemberNames() {
        members.removeAll()
        for member in group.members {
            let userRef = rootRef.child("users").child(member)
            userRef.observe(.value) { (snapshot: FIRDataSnapshot!) in
                let dict = snapshot.value as! [String:Any]
                self.members.append(dict["email"] as! String)
                DispatchQueue.main.async (execute: {
                    if self.members.count == 0 {
                        self.noMembersLabel.isHidden = false
                    } else {
                        self.noMembersLabel.isHidden = true
                        self.tableView.reloadData()
                    }
                })
            }
        }
        
    }
    
    @objc private func manageMembership(){
        let userRef = rootRef.child("users").child(uid).child("groups")
        let groupRef = rootRef.child("groups").child(group.id).child("members")
        if userInGroup {
            let userGroupRef = userRef.child(group.id)
            userGroupRef.removeValue()
            let groupUserRef = groupRef.child(uid)
            groupUserRef.removeValue()
            members =  members.filter{$0 != email}
            userInGroup = false
            navigationItem.rightBarButtonItem?.title = "Join Group"
        } else {
            userRef.updateChildValues([group.id:true])
            groupRef.updateChildValues([uid:true])
            userInGroup = true
            members.append(email)
            navigationItem.rightBarButtonItem?.title = "Leave Group"
        }
        DispatchQueue.main.async (execute: {
            self.tableView.reloadData()
        })
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return members.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "userCell", for: indexPath)
        let member = members[indexPath.row]
        cell.textLabel?.text = member
        return cell
    }

}

extension Array where Element: Equatable {
    
    // Remove first collection element that is equal to the given `object`:
    mutating func remove(object: Element) {
        if let index = index(of: object) {
            remove(at: index)
        }
    }
}
