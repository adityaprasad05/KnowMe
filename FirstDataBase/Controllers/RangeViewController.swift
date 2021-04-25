//
//  RangeViewController.swift
//  Time Smart
//
//  Created by Aditya Prasad on 6/27/20.
//  Copyright © 2020 Aditya Prasad. All rights reserved.
//

import UIKit
import Charts
import Firebase

class RangeViewController: UIViewController {

    @IBOutlet weak var barChartView: BarChartView!
    var dateRange = [Date]()
    var dateRangeText = [String]()
    var dateString = ""
    var myTotalActivities = [String]()
    var myTotalHours = [String]()
    var myDatesActsTimes =  [[String]]()
        
    override func loadView() {
        super.loadView()
        //print("From Range View Controller", dateRange)
        //convert Date to String
        let formatter = DateFormatter()
        formatter.dateFormat = "MMM d, YYYY"
        var iterator = 0
        //var myActivity = [String]()
        while iterator < dateRange.count {
            dateString = formatter.string(from: dateRange[iterator])
            dateRangeText.append(dateString)
            iterator += 1
        }
        //print("Date Range Text:",dateRangeText)
        
        let db = Firestore.firestore()
        let userID = Auth.auth().currentUser!.uid
        // get all activities for the user
        db.collection("users/\(userID)/activities").getDocuments { (querySnapshot, error) in
            if let error = error {
                print("Error querying documents:\(error.localizedDescription)")
            }
            else {
                print("RC: QuerySnapshot Activities Count",querySnapshot!.count as Any)
                var count = 0
                // get all documents in activities collection
                for document in querySnapshot!.documents{
                    count += 1
                    let docId = document.documentID
                    var totalTime = 0.0
                    var i = 0
                    var iteration = 0
                    while  i < self.dateRangeText.count {
                    db.collection("users/\(userID)/activities/\(docId)/dates").whereField("ActDate",  isEqualTo: self.dateRangeText[i]).getDocuments { (querySnapshot1, error1) in
                    //print("QuerySnapshot1 Dates Count",querySnapshot1!.count as Any, "docId", docId)
                    if let error1 = error1 {
                    print("Error getting documents: \(error1.localizedDescription)")
                    }
                     else{
                        for document1 in querySnapshot1!.documents {
                            //print("\(document1.documentID) => \(document1.data())")
                            let myData = document1.data()
                            let myTimeSpent = myData["TimeSpent"] as? String ?? ""
                            totalTime = totalTime + Double(myTimeSpent)!
                            } // for document 1 in querySnapshot1
                        iteration += 1
                        //print("Iteration count",iteration, docId, ":",totalTime )
                        if iteration == self.dateRangeText.count {
                            let str = String(totalTime)
                            self.myTotalActivities.append(docId)
                            self.myTotalHours.append(str)
                            print("** >>My Total Activities", self.myTotalActivities)
                            print("** >>My Total Hours", self.myTotalHours)
                        } // if iteration == self.dateRangeText.count
                    } // else
                } // db.collection ActDate isEqualTo dateRangeText [i]
                i+=1
                } // While Loop

            } //for document in querySnapshot
            } // else
            
        } // db.collection for activities
        
                    
     
} // load view
  
    
   
    
    override func viewDidAppear(_ animated: Bool) {
        
     
        super.viewDidLoad()
        print("*******View Did Load", myTotalActivities, myTotalHours)
       self.view.backgroundColor = UIColor.init(red: 0/255, green: 191/255, blue: 200/255, alpha: 1)
       self.barChartView.backgroundColor = UIColor.init(red: 0/255, green: 191/255, blue: 200/255, alpha: 1)
       customizeChart(dataPoints: myTotalActivities, values: myTotalHours.map{Double($0)} as! [Double] )
        barChartView.animate(xAxisDuration: 2.0)
    }
    
    func customizeChart (dataPoints: [String], values: [Double]) {
         var dataEntries : [BarChartDataEntry] = []
                
                for i in 0..<dataPoints.count {
                    
                  let dataEntry = BarChartDataEntry(x: Double(i), y: Double(values[i]), data: myTotalActivities)
                    dataEntries.append(dataEntry)
                }
                
               
                let chartDataSet = BarChartDataSet(entries: dataEntries)
                
               barChartView.xAxis.labelPosition = .bottom
                        
                        //barChartView.drawGridBackgroundEnabled = false
                        barChartView.legend.enabled = false
                        barChartView.drawValueAboveBarEnabled = true
                        //barChartView.drawBarShadowEnabled = false
                        //barChartView.drawMarkers = false
                        barChartView.rightAxis.enabled = false
                        barChartView.xAxis.enabled = true
                        //barChartView.xAxis.granularityEnabled = false
                        barChartView.leftAxis.enabled = false
                        barChartView.xAxis.valueFormatter = IndexAxisValueFormatter(values: myTotalActivities)
                        barChartView.leftAxis.drawAxisLineEnabled = false
                        //barChartView.leftAxis.drawGridLinesEnabled = true
                        barChartView.xAxis.granularity = 1
                        barChartView.xAxis.drawGridLinesEnabled = false
                        let limitLine = ChartLimitLine(limit: 0, label: "")
                        limitLine.lineColor = UIColor.black
                        limitLine.lineWidth = 10
                        
                        let chartData = BarChartData(dataSet: chartDataSet)
                        barChartView.data = chartData
                //        chartDataset.colors = [UIColor.red, UIColor.blue, UIColor.green]
                        chartDataSet.colors = ChartColorTemplates.joyful()

        }
    @IBAction func backPressed(_ sender: Any) {
          let calendarViewController = self.storyboard?.instantiateViewController(identifier: CalendarConstants.storyboard.calendarViewController)
                             self.view.window?.rootViewController = calendarViewController
                             self.view.window?.makeKeyAndVisible()
          
      }
    @IBAction func showCharts(_ sender: Any) {
        
        print("*******View Did Load", myTotalActivities, myTotalHours)
        self.view.backgroundColor = UIColor.init(red: 0/255, green: 191/255, blue: 200/255, alpha: 1)
        self.barChartView.backgroundColor = UIColor.init(red: 0/255, green: 191/255, blue: 200/255, alpha: 1)
        customizeChart(dataPoints: myTotalActivities, values: myTotalHours.map{Double($0)} as! [Double] )
        
    }
}

