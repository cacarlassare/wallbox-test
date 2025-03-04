//
//  FetchEnergyDataUseCase.swift
//  wallbox-test
//
//  Created by Cristian Carlassare on 04/03/2025.
//

import Foundation

class FetchEnergyDataUseCase {
    private let dataSource: EnergyReportDataSource
    
    init(dataSource: EnergyReportDataSource) {
        self.dataSource = dataSource
    }
    
    func fetchHistoricalReports() async throws -> [HistoricalReport] {
        return try await dataSource.fetchHistoricalReports()
    }
    
    func fetchLiveReport() async throws -> LiveReport {
        return try await dataSource.fetchLiveReport()
    }
}
