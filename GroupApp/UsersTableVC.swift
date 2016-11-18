//
//  UsersTableVC.swift
//  GroupApp
//
//  Created by Damonique Thomas on 11/18/16.
//  Copyright © 2016 Damonique Thomas. All rights reserved.
//

import UIKit

class UsersTableVC: UITableViewController {
    
    var userInGroup = false
    var groupName:String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        var buttonTitle = ""
        if userInGroup {
           buttonTitle = "Join Group"
        } else{
            buttonTitle = "Leave Group"
        }
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: buttonTitle, style: .plain, target: self, action: #selector(manageMembership))
        navigationItem.title = "\(groupName) Users"
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @objc private func manageMembership(){
        if userInGroup {
            
        } else {
            
        }
    }

    // MARK: - Table Functions
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 0
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 0
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }

}
