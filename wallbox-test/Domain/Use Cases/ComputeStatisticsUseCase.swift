//
//  ComputeStatisticsUseCase.swift
//  wallbox-test
//
//  Created by Cristian Carlassare on 04/03/2025.
//

import Foundation

final class ComputeStatisticsUseCase {
    
    func computeStatistics(from reports: [HistoricalReport]) -> EnergyStatistics {
        let totalBuilding = reports.reduce(0) { $0 + $1.buildingActivePower }
        let totalGrid = reports.reduce(0) { $0 + ($1.gridActivePower ?? 0) }
        let totalPV = reports.reduce(0) { $0 + $1.pvActivePower }
        
        var totalQuasarsCharged: Double = 0
        var totalQuasarsDischarged: Double = 0
        
        // Separate charged and discharged quasars
        for report in reports {
            let value = report.quasarsActivePower
            
            if value > 0 {
                totalQuasarsCharged += value
            } else if value < 0 {
                totalQuasarsDischarged += abs(value)
            }
        }
        
        return EnergyStatistics(totalBuilding: totalBuilding, totalGrid: totalGrid, totalPV: totalPV, totalQuasarsCharged: totalQuasarsCharged, totalQuasarsDischarged: totalQuasarsDischarged)
    }
}
