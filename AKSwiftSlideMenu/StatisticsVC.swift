//
//  StatisticsVC.swift
//  ScoutingDataViewer
//
//  Created by Trevor Jones on 11/13/16.
//  Copyright © 2016 Trevor. All rights reserved.
//

import Foundation
import UIKit
import Charts

class StatisticsVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var chartTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        chartTableView.tableFooterView = UIView()
        chartTableView.delegate = self
        chartTableView.dataSource = self
        chartTableView.separatorStyle = .none
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var booleanChart = false
        if(indexPath.row >= Teams.teams[Teams.selectedTeam].allIntData.count) {
            booleanChart = true
        }
        
        let cell : ChartTableCell = chartTableView.dequeueReusableCell(withIdentifier: "barGraphCell")! as! ChartTableCell
        
        cell.selectionStyle = .none
        
        var dataEntries: [BarChartDataEntry] = []
        if(!booleanChart) {
            for i in 0..<Teams.teams[Teams.selectedTeam].allIntData[indexPath.row].count {
                let dataEntry = BarChartDataEntry(x: Double(i), y: Double(Teams.teams[Teams.selectedTeam].allIntData[indexPath.row][i]))
                dataEntries.append(dataEntry)
            }
        } else {
            for i in 0..<Teams.teams[Teams.selectedTeam].allTagData[indexPath.row - Teams.teams[Teams.selectedTeam].allIntData.count].count {
                var dataEntry = BarChartDataEntry(x: Double(i), y: Double(1))
                if(Teams.teams[Teams.selectedTeam].allTagData[indexPath.row - Teams.teams[Teams.selectedTeam].allIntData.count][i]) {
                    dataEntry = BarChartDataEntry(x: Double(i), y: Double(1))
                } else {
                    dataEntry = BarChartDataEntry(x: Double(i), y: Double(0.2))
                }
                dataEntries.append(dataEntry)
            }
        }
        
        let chartDataSet = LineChartDataSet(values: dataEntries, label: "")
        cell.barChartView.leftAxis.enabled = true;
        if(indexPath.row >= Teams.teams[Teams.selectedTeam].allIntData.count) {
            chartDataSet.valueFormatter = BooleanValueFormatter()
            cell.barChartView.leftAxis.axisMaximum = 1.2;
            cell.barChartView.leftAxis.axisMinimum = 0;
            //cell.barChartView.leftAxis.drawGridLinesEnabled = false;
        } else {
            cell.barChartView.leftAxis.drawGridLinesEnabled = true;
            cell.barChartView.leftAxis.axisMaximum = chartDataSet.yMax * 1.1
            cell.barChartView.leftAxis.axisMinimum = 0
        }
        chartDataSet.setColor(NSUIColor(red:0.00, green:0.58, blue:1.00, alpha:1.0))
        chartDataSet.drawFilledEnabled = true
        chartDataSet.fillColor = NSUIColor(red:0.00, green:0.58, blue:1.00, alpha:1.0)
        let chartData = LineChartData(dataSet: chartDataSet)
        cell.barChartView.data = chartData
        cell.titleLbl.text = Teams.titles[indexPath.row]
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("You selected cell #\(indexPath.row)!")
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection: Int) -> Int {
        return Teams.teams[Teams.selectedTeam].allIntData.count + Teams.teams[Teams.selectedTeam].allTagData.count
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
