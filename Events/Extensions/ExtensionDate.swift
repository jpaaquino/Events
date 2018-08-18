//
//  ExtensionDate.swift
//  Events
//
//  Created by Joao Paulo Aquino on 2018-08-14.
//  Copyright © 2018 Joao Paulo Aquino. All rights reserved.
//

import Foundation

extension Date
{
    func convertToString(format: String ) -> String
    {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        return dateFormatter.string(from: self)
    }
    
    func addDaysToCurrentDate(n:Int) -> Date{
    let nDaysFromNow: Date = (Calendar.current as NSCalendar).date(byAdding: .day, value: n, to: self, options: [])!
     return nDaysFromNow
    }
    
}

