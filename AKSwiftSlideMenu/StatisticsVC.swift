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
        
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(refresh(_:)), for: .valueChanged)
        
        if #available(iOS 10.0, *) {
            chartTableView.refreshControl = refreshControl
        } else {
            chartTableView.backgroundView = refreshControl
        }
        
        chartTableView.tableFooterView = UIView()
        chartTableView.delegate = self
        chartTableView.dataSource = self
        chartTableView.separatorStyle = .none
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func refresh(_ refreshControl: UIRefreshControl) {
        // Do your job, when done:
        Teams.updateTeam(teamNumber: Teams.selectedTeam)
        chartTableView.reloadData()
        refreshControl.endRefreshing()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        print("Lets display this now")
        if(indexPath.row >= Teams.teams[Teams.selectedTeam].allIntData.count) {
            let cell : BarChartTableCell = chartTableView.dequeueReusableCell(withIdentifier: "barGraphCell")! as! BarChartTableCell
            return setUpBarCell(cell: cell, indexPath: indexPath)
        } else {
            let cell : LineChartTableCell = chartTableView.dequeueReusableCell(withIdentifier: "lineGraphCell")! as! LineChartTableCell
            return setUpLineCell(cell: cell, indexPath: indexPath)
        }
    }
    
    func setUpBarCell(cell : BarChartTableCell, indexPath : IndexPath) -> BarChartTableCell {
        cell.selectionStyle = .none
        var dataEntries: [BarChartDataEntry] = []
        var colors: [NSUIColor] = []
        
        for i in 0..<Teams.teams[Teams.selectedTeam].allTagData[indexPath.row - Teams.teams[Teams.selectedTeam].allIntData.count].count {
            var dataEntry = BarChartDataEntry(x: Double(i), y: Double(1))
            if(Teams.teams[Teams.selectedTeam].allTagData[indexPath.row - Teams.teams[Teams.selectedTeam].allIntData.count][i]) {
                dataEntry = BarChartDataEntry(x: Double(i), y: Double(1))
                colors.append(NSUIColor(red:0.00, green:0.58, blue:1.00, alpha:1.0))
            } else {
                dataEntry = BarChartDataEntry(x: Double(i), y: Double(0.2))
                colors.append(NSUIColor(red: 1, green: 0, blue: 0, alpha: 1))
            }
            dataEntries.append(dataEntry)
        }
        
        let chartDataSet = BarChartDataSet(values: dataEntries, label: "")
        cell.barChartView.leftAxis.enabled = true;
        chartDataSet.valueFormatter = BooleanValueFormatter()
        cell.barChartView.leftAxis.axisMaximum = 1.2;
        cell.barChartView.leftAxis.axisMinimum = 0;

        chartDataSet.setColors(colors, alpha: 1)
        let chartData = BarChartData(dataSet: chartDataSet)
        cell.barChartView.data = chartData
        cell.titleLbl.text = Teams.titles[indexPath.row]
        cell.addPercentageToLbl(pct: Teams.getPercentageTrue(data: Teams.teams[Teams.selectedTeam].allTagData[indexPath.row - Teams.teams[Teams.selectedTeam].allIntData.count]))
        return cell
    }
    
    func setUpLineCell(cell : LineChartTableCell, indexPath : IndexPath) -> LineChartTableCell {
        cell.selectionStyle = .none
        var dataEntries: [BarChartDataEntry] = []
        
        for i in 0..<Teams.teams[Teams.selectedTeam].allIntData[indexPath.row].count {
            let dataEntry = BarChartDataEntry(x: Double(i), y: Double(Teams.teams[Teams.selectedTeam].allIntData[indexPath.row][i]))
            dataEntries.append(dataEntry)
        }
        
        let chartDataSet = LineChartDataSet(values: dataEntries, label: "")
        cell.lineChartView.leftAxis.enabled = true;
        cell.lineChartView.leftAxis.drawGridLinesEnabled = true;
        cell.lineChartView.leftAxis.axisMaximum = chartDataSet.yMax * 1.15
        cell.lineChartView.leftAxis.axisMinimum = 0
        chartDataSet.setColor(NSUIColor(red:0.00, green:0.58, blue:1.00, alpha:1.0))
        chartDataSet.drawFilledEnabled = true
        chartDataSet.fillColor = NSUIColor(red:0.00, green:0.58, blue:1.00, alpha:1.0)
        chartDataSet.setCircleColor(NSUIColor(red:0.00, green:0.58, blue:1.00, alpha:1.0))
        
        let chartData = LineChartData(dataSet: chartDataSet)
        cell.lineChartView.data = chartData
        cell.titleLbl.text = Teams.titles[indexPath.row]
        cell.addAverageToLbl(avg: Teams.getAverageValue(data: Teams.teams[Teams.selectedTeam].allIntData[indexPath.row]))
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
