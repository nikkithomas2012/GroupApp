//
//  GroupTableVC.swift
//  GroupApp
//
//  Created by Damonique Thomas on 11/18/16.
//  Copyright © 2016 Damonique Thomas. All rights reserved.
//

import UIKit
import Firebase

class GroupTableVC: UITableViewController {
        
    @IBOutlet weak var noGroupsLabel: UILabel!
    let rootRef = FIRDatabase.database().reference().child("groups")
    var groups = [Group]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        self.noGroupsLabel.isHidden = true
       navigationItem.title = "All Groups"
    }
    
    override func viewDidAppear(_ animated: Bool) {
        getGroups()
    }
    
    private func getGroups(){
        groups.removeAll()
        rootRef.observe(.value) { (snapshot: FIRDataSnapshot!) in
            for item in snapshot.children {
                let group = Group(snapshot:item as! FIRDataSnapshot)
                self.groups.append(group)
                DispatchQueue.main.async (execute: {
                    if self.groups.count == 0 {
                        self.noGroupsLabel.isHidden = false
                    } else {
                        self.noGroupsLabel.isHidden = true
                        self.tableView.reloadData()
                    }
                })
            }
        }
    }
        
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return groups.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "groupCell", for: indexPath)
        let group = groups[indexPath.row]
        cell.textLabel?.text = group.name
        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "viewUsersSegue", sender: indexPath.row)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "viewUsersSegue" {
            let controller = segue.destination as! UsersTableVC
            let index = sender as! Int
            controller.group = groups[index]
        }
    }

}
