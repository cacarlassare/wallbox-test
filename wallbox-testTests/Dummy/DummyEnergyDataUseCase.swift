//
//  DummyEnergyDataUseCase.swift
//  wallbox-test
//
//  Created by Cristian Carlassare on 04/03/2025.
//

import Foundation
@testable import wallbox_test

// A dummy version of FetchEnergyDataUseCase to simulate responses
final class DummyEnergyDataUseCase: FetchEnergyDataUseCase {
    var fakeHistoricalReports: [HistoricalReport] = []
    var fakeLiveReport: LiveReport?
    
    override func fetchHistoricalReports() async throws -> [HistoricalReport] {
        return fakeHistoricalReports
    }
    
    override func fetchLiveReport() async throws -> LiveReport {
        if let report = fakeLiveReport {
            return report
        } else {
            throw NSError(domain: "DummyError", code: -1, userInfo: nil)
        }
    }
}
