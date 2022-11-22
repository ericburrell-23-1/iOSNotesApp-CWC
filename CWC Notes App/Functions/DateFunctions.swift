//
//  DateFunctions.swift
//  CWC Notes App
//
//  Created by Eric Burrell on 11/17/22.
//

import Foundation

func currentDate() -> String {
    // Create Date
    let date = Date()

    // Create Date Formatter
    let dateFormatter = DateFormatter()

    // Set Date/Time Style
    dateFormatter.dateStyle = .long
    dateFormatter.timeStyle = .short
    
    let dateString = dateFormatter.string(from: date)
    return dateString
    
    //return "Debugging"
}
