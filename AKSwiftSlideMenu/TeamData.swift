//
//  TeamData.swift
//  ScoutingDataViewer
//
//  Created by Trevor Jones on 11/8/16.
//  Copyright © 2016 Trevor. All rights reserved.
//

import Foundation
import Firebase
import FirebaseDatabase

class TeamData {
    var name : String?
    var number : Int?
    
    init(name : String, number : Int) {
        self.name = name
        self.number = number
    }
}

class Teams {
    static var teams = [TeamData]()
    
    static func loadData() {
        let ref : FIRDatabaseReference = FIRDatabase.database().reference()
        
        ref.child("Teams").observeSingleEvent(of: .value, with: { (snapshot) in
            let enumerator = snapshot.children
            while let rest = enumerator.nextObject() as? FIRDataSnapshot {
                let teamName = (rest.value as? NSDictionary)?["name"] as? String ?? ""
                let teamNumber = rest.key
                let team = TeamData(name: teamName, number: Int(teamNumber)!)
                self.teams.append(team)
            }
        })
    }
}
