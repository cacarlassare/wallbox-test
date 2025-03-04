//
//  DashboardViewModelTests.swift
//  wallbox-test
//
//  Created by Cristian Carlassare on 04/03/2025.
//

import XCTest
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

final class DashboardViewModelTests: XCTestCase {
    var viewModel: DashboardViewModel!
    var fakeUseCase: DummyEnergyDataUseCase!
    var computeStatsUseCase: ComputeStatisticsUseCase!
    
    override func setUp() {
        super.setUp()
        fakeUseCase = DummyEnergyDataUseCase(dataSource: JSONFileEnergyReportDataSource())
        computeStatsUseCase = ComputeStatisticsUseCase()
        viewModel = DashboardViewModel(fetchUseCase: fakeUseCase, computeStatsUseCase: computeStatsUseCase)
    }
    
    override func tearDown() {
        viewModel = nil
        fakeUseCase = nil
        computeStatsUseCase = nil
        super.tearDown()
    }
    
    func testLoadDataSuccess() async {
        
        // Dummy historical reports
        let historicalReports = [
            HistoricalReport(buildingActivePower: 100, gridActivePower: 60, pvActivePower: 30, quasarsActivePower: -10, timestamp: Date()),
            HistoricalReport(buildingActivePower: 200, gridActivePower: 120, pvActivePower: 60, quasarsActivePower: 20, timestamp: Date())
        ]
        
        fakeUseCase.fakeHistoricalReports = historicalReports
        fakeUseCase.fakeLiveReport = LiveReport(solarPower: 50, quasarsPower: 5, gridPower: 70, buildingDemand: 150, systemSoc: 80, totalEnergy: 1000, currentEnergy: 500)
        
        // Wait as "viewModel.loadData" method dispatches a Task
        let expectation = XCTestExpectation()
        expectation.isInverted = true
        
        await viewModel.loadData()
        
        await fulfillment(of: [expectation], timeout: 0.5)
                
        XCTAssertNotNil(viewModel.liveReport)
        XCTAssertNotNil(viewModel.energyStatistics)
        XCTAssertFalse(viewModel.isLoading)
        XCTAssertNil(viewModel.errorMessage) // Expected no error message on success
    }
    
    func testLoadDataFailure() async {
        
        // Simulate failure by not providing liveReport
        fakeUseCase.fakeHistoricalReports = []
        fakeUseCase.fakeLiveReport = nil
        
        // Wait as "viewModel.loadData" method dispatches a Task
        let expectation = XCTestExpectation()
        expectation.isInverted = true
        
        await viewModel.loadData()
        
        await fulfillment(of: [expectation], timeout: 0.5)
        
        XCTAssertNotNil(viewModel.errorMessage) // Expected an error message when data fetch fails
        XCTAssertFalse(viewModel.isLoading)
    }
}
