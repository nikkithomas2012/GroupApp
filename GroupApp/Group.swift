//
//  Group.swift
//  GroupApp
//
//  Created by Damonique Thomas on 11/22/16.
//  Copyright © 2016 Damonique Thomas. All rights reserved.
//

import Foundation

struct Group {
    let name: String
    let members: [String]
    
    
    init(name:String){
        self.name = name
        members = [String]()
    }
    
    func addMember(uid:String){
        members.append(uid)
    }
    
    func toAnyObject() -> Any {
        var memberObj: [String:Bool] = [:]
        for member in members {
            memberObj.updateValue(true, forKey: member)
        }
        return [
            "name": name,
            "members":memberObj
        ]
    }
}
