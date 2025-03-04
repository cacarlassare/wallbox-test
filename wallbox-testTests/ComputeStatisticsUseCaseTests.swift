//
//  ComputeStatisticsUseCaseTests.swift
//  wallbox-test
//
//  Created by Cristian Carlassare on 04/03/2025.
//

import XCTest
@testable import wallbox_test

final class ComputeStatisticsUseCaseTests: XCTestCase {
    var useCase: ComputeStatisticsUseCase!
    
    override func setUp() {
        super.setUp()
        useCase = ComputeStatisticsUseCase()
    }
    
    override func tearDown() {
        useCase = nil
        super.tearDown()
    }
    
    func testComputeStatisticsWithValidData() {
        
        // Dummy historical reports
        let reports = [
            HistoricalReport(buildingActivePower: 100, gridActivePower: 60, pvActivePower: 30, quasarsActivePower: -10, timestamp: Date()),
            HistoricalReport(buildingActivePower: 200, gridActivePower: 120, pvActivePower: 60, quasarsActivePower: 20, timestamp: Date())
        ]
        
        let stats = useCase.computeStatistics(from: reports)
        
        // Expected totals:
        // totalBuilding = 100 + 200 = 300
        // totalGrid = 60 + 120 = 180
        // totalPV = 30 + 60 = 90
        // totalQuasarsCharged = 20
        // totalQuasarsDischarged = abs(-10) = 10
        XCTAssertEqual(stats.totalBuilding, 300)
        XCTAssertEqual(stats.totalGrid, 180)
        XCTAssertEqual(stats.totalPV, 90)
        XCTAssertEqual(stats.totalQuasarsCharged, 20)
        XCTAssertEqual(stats.totalQuasarsDischarged, 10)
        
        // Expected percentages:
        // gridPercentage = (180 / 300) * 100 = 60%
        // pvPercentage = (90 / 300) * 100 = 30%
        // quasarsChargedPercentage = (20 / 300) * 100 ≈ 6.67%
        XCTAssertEqual(stats.gridPercentage, 60)
        XCTAssertEqual(stats.pvPercentage, 30)
        XCTAssertEqual(stats.quasarsChargedPercentage, (20 / 300) * 100)
    }
    
    func testComputeStatisticsWithZeroBuildingPower() {
        
        // When building power is zero, percentages should be zero.
        let reports = [
            HistoricalReport(buildingActivePower: 0, gridActivePower: 10, pvActivePower: 10, quasarsActivePower: 10, timestamp: Date())
        ]
        
        let stats = useCase.computeStatistics(from: reports)
        
        XCTAssertEqual(stats.gridPercentage, 0)
        XCTAssertEqual(stats.pvPercentage, 0)
        XCTAssertEqual(stats.quasarsChargedPercentage, 0)
    }
}
