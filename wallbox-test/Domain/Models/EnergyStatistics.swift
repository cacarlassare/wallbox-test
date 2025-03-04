//
//  EnergyStatistics.swift
//  wallbox-test
//
//  Created by Cristian Carlassare on 04/03/2025.
//

import Foundation

struct EnergyStatistics {
    let totalBuilding: Double
    let totalGrid: Double
    let totalPV: Double
    let totalQuasarsCharged: Double
    let totalQuasarsDischarged: Double
    
    var gridPercentage: Double { totalBuilding > 0 ? (totalGrid / totalBuilding) * 100 : 0 }
    var pvPercentage: Double { totalBuilding > 0 ? (totalPV / totalBuilding) * 100 : 0 }
    var quasarsChargedPercentage: Double { totalBuilding > 0 ? (totalQuasarsCharged / totalBuilding) * 100 : 0 }
}
