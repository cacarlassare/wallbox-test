//
//  JSONFileEnergyReportDataSource.swift
//  wallbox-test
//
//  Created by Cristian Carlassare on 03/03/2025.
//

import Foundation

struct JSONFileEnergyReportDataSource: EnergyReportDataSource {
    private let historicalDataFile = "historic_data.json"
    private let liveDataFile = "live_data.json"
    
    func fetchHistoricalReports() async throws -> [HistoricalReport] {
        return try FileLoader.loadJSON(filename: historicalDataFile, as: [HistoricalReport].self)
    }

    func fetchLiveReport() async throws -> LiveReport {
        return try FileLoader.loadJSON(filename: liveDataFile, as: LiveReport.self)
    }
}
