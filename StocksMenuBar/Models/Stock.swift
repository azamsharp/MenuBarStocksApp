//
//  Stock.swift
//  StocksMenuBar
//
//  Created by Mohammad Azam on 4/24/22.
//

import Foundation

struct Stock: Decodable {
    let symbol: String
    let description: String
    let price: Double 
}
