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
    // Basic Team Data
    var name : String?
    var number : String?
    
    // Data per match
    var autoPoints = [Int]()
    var linesCrossed = [Int]()
    var autoBunnies = [Int]()
    var teleopBunnies = [Int]()
    var nerfHits = [Int]()
    
    var allIntData = [[Int]]()
    
    // Tags
    var jank = [Bool]()
    var broken = [Bool]()
    var fast = [Bool]()
    var auto = [Bool]()
    var bunnies = [Bool]()
    
    var allTagData = [[Bool]]()
    
    init(name : String, number : String) {
        self.name = name
        self.number = number
    }
}

class Teams {
    static var titles : [String] = ["Auto Points", "Lines Crossed", "Auto Bunnies", "Teleop Bunnies", "Nerf Gun Hits", "Jank", "Broken", "Fast", "Auto", "Bunnies"]
    static var teams = [TeamData]()
    static var selectedTeam = 0
    static var currentSnapshot : FIRDataSnapshot?
    
    
    static func loadData() {
        FIRDatabase.database().persistenceEnabled = true
        let ref : FIRDatabaseReference = FIRDatabase.database().reference()
        
        ref.child("team").observeSingleEvent(of: .value, with: { (snapshot) in
            let enumerator = snapshot.children
            while let rest = enumerator.nextObject() as? FIRDataSnapshot {
                let teamName = (rest.value as? NSDictionary)?["name"] as? String ?? ""
                let teamNumber = rest.key
                let team = TeamData(name: teamName, number: String(teamNumber)!)
                self.teams.append(team)
            }
        })
        
        ref.child("team").observe(FIRDataEventType.value, with: { (snapshot) in
            currentSnapshot = snapshot
            print("Match updated")
        })
    }
    
    static func updateTeam(teamNumber : Int) {
        teams[teamNumber].autoPoints = [Int]();
        teams[teamNumber].linesCrossed = [Int]();
        teams[teamNumber].autoBunnies = [Int]();
        teams[teamNumber].teleopBunnies = [Int]();
        teams[teamNumber].nerfHits = [Int]();
        
        teams[teamNumber].jank = [Bool]();
        teams[teamNumber].broken = [Bool]();
        teams[teamNumber].fast = [Bool]();
        teams[teamNumber].auto = [Bool]();
        teams[teamNumber].bunnies = [Bool]();
        
        let childPath : String =  "\(teams[teamNumber].number ?? "0")/matches"
        let enumerator = currentSnapshot?.childSnapshot(forPath: childPath).children
        while let rest = enumerator?.nextObject() as? FIRDataSnapshot {
            teams[teamNumber].autoPoints.append((rest.value as? NSDictionary)?["autoPoints"] as? Int ?? 0)
            teams[teamNumber].linesCrossed.append((rest.value as? NSDictionary)?["linesCrossed"] as? Int ?? 0)
            teams[teamNumber].autoBunnies.append((rest.value as? NSDictionary)?["autoBunnies"] as? Int ?? 0)
            teams[teamNumber].teleopBunnies.append((rest.value as? NSDictionary)?["teleopBunnies"] as? Int ?? 0)
            teams[teamNumber].nerfHits.append((rest.value as? NSDictionary)?["nerfHits"] as? Int ?? 0)
            
            teams[teamNumber].jank.append((rest.value as? NSDictionary)?["jank"] as? Bool ?? false)
            teams[teamNumber].broken.append((rest.value as? NSDictionary)?["broken"] as? Bool ?? false)
            teams[teamNumber].fast.append((rest.value as? NSDictionary)?["fast"] as? Bool ?? false)
            teams[teamNumber].auto.append((rest.value as? NSDictionary)?["auto"] as? Bool ?? false)
            teams[teamNumber].bunnies.append((rest.value as? NSDictionary)?["bunnies"] as? Bool ?? false)
        }
        teams[teamNumber].allIntData = [[Int]]()
        teams[teamNumber].allIntData.append(teams[teamNumber].autoPoints)
        teams[teamNumber].allIntData.append(teams[teamNumber].linesCrossed)
        teams[teamNumber].allIntData.append(teams[teamNumber].autoBunnies)
        teams[teamNumber].allIntData.append(teams[teamNumber].teleopBunnies)
        teams[teamNumber].allIntData.append(teams[teamNumber].nerfHits)
        
        teams[teamNumber].allTagData = [[Bool]]()
        teams[teamNumber].allTagData.append(teams[teamNumber].jank)
        teams[teamNumber].allTagData.append(teams[teamNumber].broken)
        teams[teamNumber].allTagData.append(teams[teamNumber].fast)
        teams[teamNumber].allTagData.append(teams[teamNumber].auto)
        teams[teamNumber].allTagData.append(teams[teamNumber].bunnies)
    }
    
    static func getAverageValue(data : [Int]) -> Double {
        var total : Double = 0
        for i in 0..<data.count {
            total += Double(data[i])
        }
        return (total/Double(data.count))
    }
    
    static func getPercentageTrue(data : [Bool]) -> Double {
        var totalTrue : Double = 0
        for i in 0..<data.count {
            if data[i] {
                totalTrue += 1
            }
        }
        return (totalTrue/Double(data.count))
    }
}
