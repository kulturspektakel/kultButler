//
//  ProductView.swift
//  kultButler
//
//  Created by Tristan Häuser on 13.04.21.
//

import SwiftUI

struct PriceLabel: View {
    let price: Int
    
    let formatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.currencyCode = "EUR"
        return formatter
    }()

    
    var body: some View {
        Text(formatter.string(from: NSNumber(value: Double(self.price) / 100)) ?? "")
    }
}
