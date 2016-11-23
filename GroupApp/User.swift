//
//  User.swift
//  GroupApp
//
//  Created by Damonique Thomas on 11/22/16.
//  Copyright © 2016 Damonique Thomas. All rights reserved.
//

import Foundation

struct User {
    let email: String
    let name: String
    var groups: [String]
    
    init(email: String, name: String){
        self.email = email
        self.name = name
        groups = [String]()
    }
    
    mutating func addGroup(groupName:String) {
        groups.append(groupName)
    }
    
    func toAnyObject() -> Any {
        var groupObj: [String:Bool] = [:]
        for group in groups {
            groupObj.updateValue(true, forKey: group)
        }
        return [
            "email": email,
            "name": name,
            "groups":groupObj
        ]
    }
}
