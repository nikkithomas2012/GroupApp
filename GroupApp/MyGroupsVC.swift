//
//  MyGroupsVC.swift
//  GroupApp
//
//  Created by Damonique Thomas on 11/18/16.
//  Copyright © 2016 Damonique Thomas. All rights reserved.
//

import UIKit
import Firebase

class MyGroupsVC: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var noGroupsLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    var groups = [Group]()
    let rootRef = FIRDatabase.database().reference()
    var ref: FIRDatabaseReference!
    
    override func viewDidAppear(_ animated: Bool) {
        getGroups()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        automaticallyAdjustsScrollViewInsets = false;
        tableView.delegate = self
        tableView.dataSource = self
        navigationController?.navigationBar.isHidden = true
        let uid =  UserDefaults.standard.object(forKey:"uid") as! String
        ref = rootRef.child("users").child(uid).child("groups")
    }

    private func getGroups(){
        groups.removeAll()
        ref.observe(.value) { (snapshot: FIRDataSnapshot!) in
            for item in snapshot.children {
                let id = (item as! FIRDataSnapshot).key
                let groupRef = self.rootRef.child("groups").child(id)
                groupRef.observe(.value) { (snapshot: FIRDataSnapshot!) in
                    let group = Group(snapshot:snapshot)
                    self.groups.append(group)
                    DispatchQueue.main.async (execute: {
                        self.tableView.reloadData()
                        if self.groups.count == 0 {
                            self.noGroupsLabel.isHidden = false
                        } else {
                            self.noGroupsLabel.isHidden = true
                        }
                    })
                }
            }
        }
        
    }
    
    @IBAction func logOut(_ sender: UIButton) {
        try! FIRAuth.auth()!.signOut()
        UserDefaults.standard.setValue(nil, forKey: "uid")
        if let storyboard = self.storyboard {
            let vc = storyboard.instantiateViewController(withIdentifier: "loginVC") as! LoginVC
            self.present(vc, animated: false, completion: nil)
        }
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return groups.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "myGroupCell", for: indexPath)
        let group = groups[indexPath.row]
        cell.textLabel?.text = group.name
        return cell
    }
}
