//
//  ViewModelsFactory.swift
//  wallbox-test
//
//  Created by Cristian Carlassare on 04/03/2025.
//

import Foundation

struct ViewModelsFactory {
    
    static func makeDashboardViewModel() -> DashboardViewModel {
        let dataSource = JSONFileEnergyReportDataSource()
        let fetchUseCase = FetchEnergyDataUseCase(dataSource: dataSource)
        let computeStatsUseCase = ComputeStatisticsUseCase()
        
        return DashboardViewModel(fetchUseCase: fetchUseCase, computeStatsUseCase: computeStatsUseCase)
    }
    
    static func makeReportDetailViewModel() -> ReportDetailViewModel {
        let dataSource = JSONFileEnergyReportDataSource()
        let fetchUseCase = FetchEnergyDataUseCase(dataSource: dataSource)
        
        return ReportDetailViewModel(fetchUseCase: fetchUseCase)
    }
}
