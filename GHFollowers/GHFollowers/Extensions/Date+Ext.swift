//
//  Date+Ext.swift
//  GHFollowers
//
//  Created by Blaze macbook pro on 25/08/24.
//

import Foundation

extension Date{
    
    func convertToMonthYearFormat()->String{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM yyyy"
        return dateFormatter.string(from: self)
    }
}

extension String{
    
    func convertToDate()-> Date?{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.timeZone = .current
        
        return dateFormatter.date(from: self)
    }
    
    func convertToDisplayDate() -> String{
        guard let date = self.convertToDate() else {return "N/A"}
        
        return date.convertToMonthYearFormat()
    }
}
