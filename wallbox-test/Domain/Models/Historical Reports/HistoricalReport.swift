//
//  HistoricalReport.swift
//  wallbox-test
//
//  Created by Cristian Carlassare on 02/03/2025.
//

import Foundation

struct HistoricalReport: Codable {
    let buildingActivePower: Double
    let gridActivePower: Double
    let pvActivePower: Double
    let quasarsActivePower: Double
    let timestamp: Date
    
    enum CodingKeys: String, CodingKey {
        case buildingActivePower = "building_active_power"
        case gridActivePower = "grid_active_power"
        case pvActivePower = "pv_active_power"
        case quasarsActivePower = "quasars_active_power"
        case timestamp
    }
}
