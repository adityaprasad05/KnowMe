//
//  PieChartViewController.swift
//  FirstDataBase
//
//  Created by Aditya Prasad on 6/21/20.
//  Copyright © 2020 Aditya Prasad. All rights reserved.
//

import UIKit
import Charts
import Firebase

class PieChartViewController: UIViewController {
    
    
    @IBOutlet weak var pieChartView: PieChartView!
    var acts = [String]()
       var times = [String]()
       
       override func viewDidLoad() {
           super.viewDidLoad()
        self.view.backgroundColor = UIColor.init(red: 0/255, green: 191/255, blue: 200/255, alpha: 1)
        self.pieChartView.backgroundColor = UIColor.init(red: 0/255, green: 191/255, blue: 200/255, alpha: 1)
        let db = Firestore.firestore()
        let userId = Auth.auth().currentUser!.uid
        db.collection("users/\(userId)/activities").getDocuments { (querySnapshot, error) in
            if let error = error{
                print("Error getting document:\(error.localizedDescription)")
                        }
            else{
                print("QuerySnapshot Activities Count",querySnapshot!.count as Any)
                    var count = 0
                           
                           
            for document in querySnapshot!.documents{
                count += 1
                let docId = document.documentID
                print("Aditya Count: \(count),\(document.data()), \(docId)")
                                //print("Aditya, Before querying dates collection")
            db.collection("users/\(userId)/activities/\(docId)/dates").getDocuments { (querySnapshot1, error1) in
                                
                    print("QuerySnapshot1 Dates Count",querySnapshot1!.count as Any, "docId", docId)
                                    
                    if let error1 = error1 {
                    print("Error getting documents: \(error1.localizedDescription)")
                                    }
                    else{
                    var iteration = 0
                                        
                    for document1 in querySnapshot1!.documents {
                        iteration += 1
                        print("Rakesh iteration count",iteration)
                        print("\(document1.documentID) => \(document1.data())")
                        
                                                }

                                            }
                                    //print("Total Time =>", totalTime)

                                    }
                                //print("Aditya, After querying dates collection")
                            }

                        }
                }
            
        
        
           //barChartView.xAxis.valueFormatter =
           //barChartView.drawBordersEnabled = false
           customizeChart(dataPoints: acts, values: times.map{Double($0)} as! [Double] )
           pieChartView.animate(xAxisDuration: 2.0, yAxisDuration: 2.0)
           print("From PieChart :\(acts), \(times)")
       }
       
       func customizeChart(dataPoints: [String], values: [Double]) {
          
           // 1. Set ChartDataEntry
           var dataEntries : [ChartDataEntry] = []
           
           for i in 0..<dataPoints.count {
               
              //let dataEntry = BarChartDataEntry(x: Double(i), y: Double(values[i]))
             let dataEntry = ChartDataEntry(x: Double(i), y: Double(values[i]), data: acts)
               dataEntries.append(dataEntry)
           }
        let pieChartDataSet = PieChartDataSet(entries: dataEntries)
        let pieChartData = PieChartData(dataSet: pieChartDataSet)
        pieChartView.data = pieChartData
        pieChartDataSet.colors = ChartColorTemplates.colorful()
        pieChartView.legend.enabled = false
        pieChartView.drawEntryLabelsEnabled = true
    }
    @IBAction func backPressed(_ sender: Any) {
        
    }
    

}
