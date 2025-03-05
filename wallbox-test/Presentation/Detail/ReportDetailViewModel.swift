//
//  ReportDetailViewModel.swift
//  wallbox-test
//
//  Created by Cristian Carlassare on 02/03/2025.
//

import Foundation

final class ReportDetailViewModel: ObservableObject, @unchecked Sendable {
    @Published var historicalReports: [HistoricalReport] = []
    @Published var isLoading: Bool = false
    @Published var errorMessage: String?
    
    private let fetchUseCase: FetchEnergyDataUseCase
    
    
    init(fetchUseCase: FetchEnergyDataUseCase) {
        self.fetchUseCase = fetchUseCase
    }
    
    func loadHistoricalData() {
        isLoading = true
        
        Task {
            do {
                let reports = try await fetchUseCase.fetchHistoricalReports()
                
                await MainActor.run {
                    self.historicalReports = reports
                    self.isLoading = false
                }
            } catch {
                
                await MainActor.run {
                    self.errorMessage = error.localizedDescription
                    self.isLoading = false
                }
            }
        }
    }
    
    // Computed property that transforms historicalReports into chart data points
    var dataPoints: [EnergyDataPoint] {
        historicalReports.flatMap { report in
            [
                EnergyDataPoint(timestamp: report.timestamp, source: "Building", value: report.buildingActivePower),
                EnergyDataPoint(timestamp: report.timestamp, source: "Grid", value: report.gridActivePower),
                EnergyDataPoint(timestamp: report.timestamp, source: "PV", value: report.pvActivePower),
                EnergyDataPoint(timestamp: report.timestamp, source: "Quasars", value: report.quasarsActivePower)
            ]
        }
    }
}
