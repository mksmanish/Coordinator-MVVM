//
//  Date + Extensions.swift
//  Coordinator
//
//  Created by Tradesocio on 19/05/22.
//

import Foundation
extension Date {
    func timeRemaning(until endate: Date) -> String? {
        
        let dateComponentsFormatter = DateComponentsFormatter()
        dateComponentsFormatter.allowedUnits = [.year, .month, .weekOfMonth, .day]
        dateComponentsFormatter.unitsStyle = .full
        return dateComponentsFormatter.string(from: self, to: endate) ?? ""
        
    }
}
