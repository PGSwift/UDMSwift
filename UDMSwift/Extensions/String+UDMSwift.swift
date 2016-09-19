//
//  String+UDMSwift.swift
//  UDMSwift
//
//  Created by OSXVN on 9/17/16.
//  Copyright © 2016 XUANVINHTD. All rights reserved.
//

import Foundation

extension String {
    
    func formatDateFromString(value: String) -> String? {
        
        let formatter = NSDateFormatter()
        formatter.dateFormat = "yyyy-MM-dd hh:mm:ss"
        let someDateTime = formatter.dateFromString(value)
        
        formatter.dateFormat = UDMConfig.formatDate
        
        return formatter.stringFromDate(someDateTime!)
    }
}
