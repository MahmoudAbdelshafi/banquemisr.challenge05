//
//  String+FormattedDate.swift
//  Presentation
//
//  Created by Mahmoud Abdelshafi on 02/07/2024.
//

import Foundation

extension String {
    var formattedDate: String {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        
        if let date = dateFormatter.date(from: (self)) {
            dateFormatter.dateStyle = .medium
            return dateFormatter.string(from: date)
        } else {
            return "Unknown Date"
        }
    }
}
