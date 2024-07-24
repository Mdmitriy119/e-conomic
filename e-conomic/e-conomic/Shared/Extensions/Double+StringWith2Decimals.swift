//
//  Double+StringWith2Decimals.swift
//  e-conomic
//
//  Created by Dumitru Manea on 24.07.2024.
//

import Foundation

extension Double {
    var stringWith2Decimals: String {
        String(format: "%.2f", self)
    }
}
