//
//  App+Extensions.swift
//  Calendar
//
//  Created by Nitin Bhatt on 9/22/20.
//  Copyright © 2020 Test. All rights reserved.
//

import Foundation

extension Date {
    var monthAndYear: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM yyyy"
        return dateFormatter.string(from: self)
    }
    
    func getDayInWeek()->String{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "E"
        return dateFormatter.string(from: self)
    }
    
    func dateToString()->String{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        return dateFormatter.string(from: self)
    }
}

let defaultDateFormat = "dd MMM yyyy"
let jsonDateFormat = "yyyy-MM-dd'T'HH:mm:ss"

func convertStringDateFormatToDate(value:String,dateFormat:String)->Date {
    let dateFormatter = DateFormatter()
    dateFormatter.locale = Locale(identifier: "en_GB")
    dateFormatter.timeZone = TimeZone(abbreviation: "EST")
    dateFormatter.dateFormat = dateFormat
    return dateFormatter.date(from: value)!
 }
