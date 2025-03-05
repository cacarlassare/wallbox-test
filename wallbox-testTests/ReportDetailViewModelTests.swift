//
//  ReportDetailViewModelTests.swift
//  wallbox-test
//
//  Created by Cristian Carlassare on 04/03/2025.
//

import XCTest
@testable import wallbox_test

final class ReportDetailViewModelTests: XCTestCase {
    var viewModel: ReportDetailViewModel!
    var fakeUseCase: DummyEnergyDataUseCase!
    
    override func setUp() {
        super.setUp()
        fakeUseCase = DummyEnergyDataUseCase(dataSource: JSONFileEnergyReportDataSource())
        viewModel = ReportDetailViewModel(fetchUseCase: fakeUseCase)
    }
    
    override func tearDown() {
        viewModel = nil
        fakeUseCase = nil
        super.tearDown()
    }
    
    func testDataPointsMapping() {
        
        // Create dummy historical reports
        let date = Date()
        
        let report1 = HistoricalReport(buildingActivePower: 100, gridActivePower: 60, pvActivePower: 30, quasarsActivePower: -10, timestamp: date)
        let report2 = HistoricalReport(buildingActivePower: 200, gridActivePower: 120, pvActivePower: 60, quasarsActivePower: 20, timestamp: date)
        viewModel.historicalReports = [report1, report2]
        
        let dataPoints = viewModel.dataPoints
        
        // 4 data points per report
        XCTAssertEqual(dataPoints.count, 8)
        
        // Check first report
        let firstFour = Array(dataPoints.prefix(4))
        XCTAssertEqual(firstFour[0].source, "Building")
        XCTAssertEqual(firstFour[0].value, 100)
        XCTAssertEqual(firstFour[1].source, "Grid")
        XCTAssertEqual(firstFour[1].value, 60)
        XCTAssertEqual(firstFour[2].source, "PV")
        XCTAssertEqual(firstFour[2].value, 30)
        XCTAssertEqual(firstFour[3].source, "Quasars")
        XCTAssertEqual(firstFour[3].value, -10)
        
        // Check second report
        let lastFour = Array(dataPoints.suffix(4))
        XCTAssertEqual(lastFour[0].source, "Building")
        XCTAssertEqual(lastFour[0].value, 200)
        XCTAssertEqual(lastFour[1].source, "Grid")
        XCTAssertEqual(lastFour[1].value, 120)
        XCTAssertEqual(lastFour[2].source, "PV")
        XCTAssertEqual(lastFour[2].value, 60)
        XCTAssertEqual(lastFour[3].source, "Quasars")
        XCTAssertEqual(lastFour[3].value, 20)
    }
}
