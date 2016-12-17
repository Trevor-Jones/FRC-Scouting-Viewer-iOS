//
//  BooleanValueFormatter.swift
//  ScoutingDataViewer
//
//  Created by Trevor Jones on 12/16/16.
//  Copyright © 2016 Trevor. All rights reserved.
//

import UIKit
import Charts

class BooleanValueFormatter: NSObject, IValueFormatter {
    
    func stringForValue(_ value: Double, entry: ChartDataEntry, dataSetIndex: Int, viewPortHandler: ViewPortHandler?) -> String {
        if(value == 1) {
            return "True"
        } else {
            return "False"
        }
    }
}
