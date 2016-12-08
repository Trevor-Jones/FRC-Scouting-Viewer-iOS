//
//  StatisticsVC.swift
//  ScoutingDataViewer
//
//  Created by Trevor Jones on 11/13/16.
//  Copyright © 2016 Trevor. All rights reserved.
//

import Foundation
import UIKit

class StatisticsVC: UIViewController {
    
    @IBOutlet weak var gamesWonLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        gamesWonLabel.text = "Games won: \(Teams.teams[Teams.selectedTeam].autoPoints[0])"
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
}
