//
//  EnergyReportDataSourceTests.swift
//  wallbox-test
//
//  Created by Cristian Carlassare on 03/03/2025.
//

import XCTest
@testable import wallbox_test

final class EnergyReportDataSourceTests: XCTestCase {
    var dataSource: EnergyReportDataSource!

    override func setUp() {
        super.setUp()
        
        // Use the JSON-based data source
        dataSource = JSONFileEnergyReportDataSource()
    }

    override func tearDown() {
        dataSource = nil
        super.tearDown()
    }

    func testFetchHistoricalReports() async throws {
        
        // Fetch historical reports asynchronously
        let reports = try await dataSource.fetchHistoricalReports()
        
        // Assert that the fetched reports are not empty
        XCTAssertFalse(reports.isEmpty)
    }

    func testFetchLiveReport() async throws {
        
        // Fetch the live report asynchronously
        let liveReport = try await dataSource.fetchLiveReport()
        
        // Assert that we've fetched a live report
        XCTAssertNotNil(liveReport)
    }
}
