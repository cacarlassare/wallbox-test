//
//  DashboardViewModel.swift
//  wallbox-test
//
//  Created by Cristian Carlassare on 02/03/2025.
//

import Foundation


final class DashboardViewModel: ObservableObject, @unchecked Sendable {
    @Published var liveReport: LiveReport?
    @Published var energyStatistics: EnergyStatistics?
    @Published var isLoading: Bool = false
    @Published var errorMessage: String?
    
    private let fetchUseCase: FetchEnergyDataUseCase
    private let computeStatsUseCase: ComputeStatisticsUseCase
    
    init(fetchUseCase: FetchEnergyDataUseCase, computeStatsUseCase: ComputeStatisticsUseCase) {
        self.fetchUseCase = fetchUseCase
        self.computeStatsUseCase = computeStatsUseCase
    }
    
    @MainActor
    func loadData() {
        isLoading = true
        
        Task {
            do {
                let historicalReports = try await self.fetchUseCase.fetchHistoricalReports()
                let liveReport = try await self.fetchUseCase.fetchLiveReport()
                let stats = self.computeStatsUseCase.computeStatistics(from: historicalReports)
                
                await MainActor.run {
                    self.liveReport = liveReport
                    self.energyStatistics = stats
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
}
