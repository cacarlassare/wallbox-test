//
//  wallbox_testApp.swift
//  wallbox-test
//
//  Created by Cristian Carlassare on 02/03/2025.
//

import SwiftUI

@main
struct wallbox_testApp: App {
    
    var body: some Scene {
        WindowGroup {
            DashboardView(viewModel: makeDashboardViewModel())
        }
    }
    
    // Factory method to create the DashboardViewModel with all dependencies
    private func makeDashboardViewModel() -> DashboardViewModel {
        let dataSource = JSONFileEnergyReportDataSource()
        let fetchUseCase = FetchEnergyDataUseCase(dataSource: dataSource)
        let computeStatsUseCase = ComputeStatisticsUseCase()
        
        return DashboardViewModel(fetchUseCase: fetchUseCase, computeStatsUseCase: computeStatsUseCase)
    }
}
