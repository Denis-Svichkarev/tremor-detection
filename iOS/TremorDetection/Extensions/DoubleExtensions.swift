//
//  DoubleExtensions.swift
//  TremorDetection
//
//  Created by Denis Svichkarev on 25.11.2020.
//

import Foundation

extension Double {
    func formattedString(symbolsAfterDot: Int) -> String {
        if !isNaN {
            return String(format: "%.0\(symbolsAfterDot)f", self)
        } else { return "0" }
    }
}
