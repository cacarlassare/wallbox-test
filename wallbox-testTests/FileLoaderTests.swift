//
//  FileLoaderTests.swift
//  wallbox-test
//
//  Created by Cristian Carlassare on 03/03/2025.
//

import XCTest
@testable import wallbox_test

final class FileLoaderTests: XCTestCase {
    
    func testLoadHistoricalReportJSON() throws {
        
        // Attempt to load the historical reports from the JSON file
        let reports: [HistoricalReport] = try FileLoader.loadJSON(filename: "historic_data.json", as: [HistoricalReport].self)
        
        // Check that the reports array has the expected number of items
        XCTAssertEqual(reports.count, 1125)
        
        // Check that the first report has been well parsed
        if let first = reports.first {
            XCTAssertEqual(first.buildingActivePower, 40.47342857142857)
            XCTAssertEqual(first.gridActivePower, 44.234380952380945)
            XCTAssertEqual(first.pvActivePower, 0)
            XCTAssertEqual(first.quasarsActivePower, 3.7609523809523817)
            
            let isoFormatter = ISO8601DateFormatter()
            guard let expectedDate = isoFormatter.date(from: "2021-09-26T22:01:00+00:00") else {
                XCTFail("Failed to parse the expected date")
                return
            }
            
            XCTAssertEqual(first.timestamp, expectedDate)
        }
    }
    
    func testLoadLiveReportJSON() throws {
        
        // Attempt to load the live report from the JSON file
        let liveReport: LiveReport = try FileLoader.loadJSON(filename: "live_data.json", as: LiveReport.self)
        
        // Check that live report fields have the same values from the JSON
        XCTAssertEqual(liveReport.solarPower, 7.827)
        XCTAssertEqual(liveReport.quasarsPower, -38.732)
        XCTAssertEqual(liveReport.gridPower, 80.475)
        XCTAssertEqual(liveReport.buildingDemand, 127.03399999999999)
        XCTAssertEqual(liveReport.systemSoc, 48.333333333333336)
        XCTAssertEqual(liveReport.totalEnergy, 960)
        XCTAssertEqual(liveReport.currentEnergy, 464)
    }
}
