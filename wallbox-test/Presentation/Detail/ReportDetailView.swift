//
//  ReportDetailView.swift
//  wallbox-test
//
//  Created by Cristian Carlassare on 02/03/2025.
//

import SwiftUI
import Charts

struct ReportDetailView: View {
    @StateObject var viewModel: ReportDetailViewModel
    
    var body: some View {
        VStack {
            
            if viewModel.isLoading {
                ProgressView("Loading historical data...")
                    .padding()
                
            } else if let errorMessage = viewModel.errorMessage {
                
                // Dedicated error view with a retry button
                ErrorView(errorMessage: errorMessage) {
                    viewModel.loadHistoricalData()
                }
            } else {
                Chart {
                    
                    ForEach(viewModel.dataPoints) { point in
                        LineMark(
                            x: .value("Time", point.timestamp),
                            y: .value("Power (kW)", point.value)
                        )
                        .foregroundStyle(by: .value("Source", point.source))
                        .interpolationMethod(.catmullRom)
                    }
                }
                .chartXAxis {
                    AxisMarks(values: .automatic(desiredCount: 5)) { value in
                        AxisValueLabel(format: .dateTime.hour().minute(), centered: true)
                    }
                }
                .chartYAxis {
                    AxisMarks(position: .leading)
                }
                .frame(height: 300)
                .padding()
            }
        }
        .navigationTitle("Energy Report")
        .navigationBarTitleDisplayMode(.inline)
        .onAppear {
            viewModel.loadHistoricalData()
        }
    }
}
