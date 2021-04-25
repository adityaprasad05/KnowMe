//
//  BarViewController.swift
//  FirstDataBase
//
//  Created by Aditya Prasad on 6/9/20.
//  Copyright © 2020 Aditya Prasad. All rights reserved.
//

import UIKit
import Charts
class BarViewController: UIViewController, ChartViewDelegate {

    var barChart = BarChartView()
    var months : [String]!
    override func viewDidLoad() {
        super.viewDidLoad()
        barChart.delegate = self
        barChart.animate(xAxisDuration: 2.0, yAxisDuration: 2.0)
        // Do any additional setup after loading the view.
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        barChart.frame = CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: self.view.frame.size.width)
        
        barChart.center = view.center
        
        view.addSubview(barChart)
        
        var entries = [BarChartDataEntry]()
        
        for x in 0 ..< 5 {
            entries.append(BarChartDataEntry(x:Double(x),
                                             y:3))
        }
       
        let set = BarChartDataSet(entries: entries, label: "Acting")
        set.colors = ChartColorTemplates.joyful()   
        let data = BarChartData(dataSet: set)
        barChart.data = data
    }
    

}
