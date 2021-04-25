//
//  CalendarViewController.swift
//  Time Smart
//
//  Created by Aditya Prasad on 6/26/20.
//  Copyright © 2020 Aditya Prasad. All rights reserved.
//

import UIKit
import FSCalendar
import Firebase
class CalendarViewController: UIViewController, FSCalendarDelegate, FSCalendarDataSource {
    @IBOutlet weak var calendarView: FSCalendar!
    
    // first date in the range
    private var firstDate: Date?
    //last date in the range
    private var lastDate: Date?
    // array of dates to hold value dates between firstDate and lastDate
    var dateRange = [Date]()
   
   
    
   
    
    override func viewDidLoad() {
        self.view.backgroundColor = UIColor.init(red: 0/255, green: 191/255, blue: 200/255, alpha: 1)
        self.calendarView.backgroundColor = UIColor.init(red: 0/255, green: 191/255, blue: 200/255, alpha: 1)
        super.viewDidLoad()
        calendarView.delegate = self
        calendarView.allowsMultipleSelection = true
        
    
    }
    @IBAction func backPressed(_ sender: Any) {
        transitionToWelcome()
    }
    
    func datesRange(from: Date, to: Date) -> [Date] {
        // in case of the "from" date is more than the "to" date
        // it should return as an empty array:
         
        if from > to { return [Date]() }
        var tempDate = from
        var array = [tempDate]
      
        while tempDate < to {
            tempDate = Calendar.current.date(byAdding: .day, value: 1, to: tempDate)!
            array.append(tempDate)
        }
        return array
    }
    
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        
        if firstDate == nil {
            firstDate = date
            dateRange = [firstDate!]
            
            print("datesRanges contain: \(dateRange)")
            
            return
        }
        //only first date is selected:
        if firstDate != nil && lastDate == nil {
            // handle the case of if the last date is less than the first date
            if date <= firstDate! {
                calendar.deselect(firstDate!)
                dateRange = [firstDate!]
                
                print("datesRange contaings: \(dateRange)")
                
                return
            }
            let range = datesRange(from: firstDate!, to: date)
            lastDate = range.last
            
            for d in range {
                calendar.select(d)
            }
            dateRange = range
            
            print("datesRange contains:\(dateRange)")
            
            return
        }
        //both are selected
        if firstDate != nil && lastDate != nil {
            for d in calendar.selectedDates {
                calendar.deselect(d)
            }
            lastDate = nil
            firstDate = nil
            
            dateRange = []
            
            print("datesRange contains:\(dateRange)")

        }
    }
    func calendar(_ calendar: FSCalendar, didDeselect date: Date, at monthPosition: FSCalendarMonthPosition) {
        // both are selected :
        
        //Note : the is a REDUNDANT CODE:
        if firstDate != nil && lastDate != nil {
            for d in calendar.selectedDates {
                calendar.deselect(d)
            }
            lastDate = nil
            firstDate = nil
            
            dateRange = []
            
        print("datesRange contains:\(dateRange)")
        }
    }
     func transitionToWelcome() {
        let welcomeNavigationController = self.storyboard?.instantiateViewController(identifier: LogInConstants.storyboard.welcomeNavigationController)
                
        self.view.window?.rootViewController = welcomeNavigationController
        self.view.window?.makeKeyAndVisible()
              }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let vc = segue.destination as! RangeViewController
        vc.dateRange = self.dateRange
    }
}
