//
//  LiveReport.swift
//  wallbox-test
//
//  Created by Cristian Carlassare on 02/03/2025.
//

import Foundation

struct LiveReport: Codable {
    let solarPower: Double
    let quasarsPower: Double
    let gridPower: Double
    let buildingDemand: Double
    let systemSoc: Double
    let totalEnergy: Int
    let currentEnergy: Int
    
    enum CodingKeys: String, CodingKey {
        case solarPower = "solar_power"
        case quasarsPower = "quasars_power"
        case gridPower = "grid_power"
        case buildingDemand = "building_demand"
        case systemSoc = "system_soc"
        case totalEnergy = "total_energy"
        case currentEnergy = "current_energy"
    }
}
