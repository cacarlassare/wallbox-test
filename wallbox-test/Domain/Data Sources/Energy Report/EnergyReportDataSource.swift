//
//  EnergyReportDataSource.swift
//  wallbox-test
//
//  Created by Cristian Carlassare on 02/03/2025.
//

import Foundation

protocol EnergyReportDataSource {
    func fetchHistoricalReports() async throws -> [HistoricalReport]
    func fetchLiveReport() async throws -> LiveReport
}
