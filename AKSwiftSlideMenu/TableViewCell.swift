//
//  ChartTableCell.swift
//  ChartsTest
//
//  Created by Trevor Jones on 12/16/16.
//  Copyright © 2016 trevor. All rights reserved.
//

import UIKit
import Charts

class ChartTableCell: UITableViewCell {
    
    
    @IBOutlet weak var barChartView: BarChartView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        barChartView.chartDescription?.enabled =  false
        barChartView.isUserInteractionEnabled = false
        barChartView.legend.enabled = false
        barChartView.leftAxis.drawLabelsEnabled = false
        barChartView.rightAxis.enabled = false
        barChartView.xAxis.enabled = false
        
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
