//
//  Report.swift
//  FirstDataBase
//
//  Created by Aditya Prasad on 6/13/20.
//  Copyright © 2020 Aditya Prasad. All rights reserved.
//

import Foundation
import Firebase
struct Report {
    let activity : String
    let hours : Int
    
}

extension Report {
    
    static func all() -> [Report] {

        
        return [
        
        
            Report(activity: "Acting", hours: 20),
            Report(activity: "Boxing", hours: 33),
            Report(activity: "Choir", hours: 12)
            
        ]
        
    }
    
    
    
}
