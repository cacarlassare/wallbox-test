//
//  EnergyDataPoint.swift
//  wallbox-test
//
//  Created by Cristian Carlassare on 05/03/2025.
//

import Foundation

struct EnergyDataPoint: Identifiable {
    let id = UUID()
    let timestamp: Date
    let source: String
    let value: Double
    
    init(timestamp: Date, source: String, value: Double?) {
        self.timestamp = timestamp
        self.source = source
        self.value = value ?? 0
    }
}
