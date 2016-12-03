//
//  Group.swift
//  GroupApp
//
//  Created by Damonique Thomas on 11/22/16.
//  Copyright © 2016 Damonique Thomas. All rights reserved.
//

import Foundation
import Firebase

struct Group {
    let id: String
    let name: String
    var members: [String]
    
    init(name:String){
        self.name = name
        members = [String]()
        id = ""
    }
    
    init(snapshot: FIRDataSnapshot) {
        id = snapshot.key
        members = [String]()
        let snapshotValue = snapshot.value as! [String: AnyObject]
        if snapshotValue["name"] != nil {
            name = snapshotValue["name"] as! String
        } else {
            name = ""
        }
        if snapshotValue["members"] != nil {
            let membersDict = snapshotValue["members"] as! [String: Bool]
            for member in membersDict {
                members.append(member.key)
            }
        }
    }
    
    mutating func addMember(uid:String){
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
