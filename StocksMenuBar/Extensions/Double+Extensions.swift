//
//  Double+Extensions.swift
//  StocksMenuBar
//
//  Created by Mohammad Azam on 4/24/22.
//

import Foundation

extension Double {
    
    func formatAsCurrency() -> String {
        
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.maximumFractionDigits = 2
        return formatter.string(from: NSNumber(value: self)) ?? "N/A"
    }
}
