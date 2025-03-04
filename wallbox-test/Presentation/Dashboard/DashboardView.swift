//
//  DashboardView.swift
//  wallbox-test
//
//  Created by Cristian Carlassare on 02/03/2025.
//

import SwiftUI

struct DashboardView: View {
    @StateObject var viewModel: DashboardViewModel
    
    // Define simple flexible column
    let columns: [GridItem] = [
        GridItem(.flexible(), spacing: 20)
    ]
    
    var body: some View {
        NavigationView {
            ScrollView {
                
                if viewModel.isLoading {
                    ProgressView("Loading...")
                        .padding()
                    
                } else if let errorMessage = viewModel.errorMessage {
                    Text("Error: \(errorMessage)")
                        .foregroundColor(.red)
                        .padding()
                    
                } else {
                    
                    LazyVGrid(columns: columns, spacing: 20) {
                        
                        // Live Data Widget
                        widgetCard {
                            VStack(alignment: .leading, spacing: 8) {
                                Text("Live Data")
                                    .font(.headline)
                                
                                if let liveReport = viewModel.liveReport {
                                    Text("Solar Power: \(liveReport.solarPower, specifier: "%.1f") kW")
                                    Text("Grid Power: \(liveReport.gridPower, specifier: "%.1f") kW")
                                    Text("Building Demand: \(liveReport.buildingDemand, specifier: "%.1f") kW")
                                } else {
                                    Text("No Live Data")
                                }
                            }
                        }
                        
                        // Quasars Charged Widget
                        widgetCard {
                            VStack(alignment: .leading, spacing: 8) {
                                Text("Quasars Charged")
                                    .font(.headline)
                                
                                if let stats = viewModel.energyStatistics {
                                    Text("\(stats.totalQuasarsCharged, specifier: "%.1f") kWh")
                                } else {
                                    Text("N/A")
                                }
                            }
                        }
                        
                        // Quasars Discharged Widget
                        widgetCard {
                            VStack(alignment: .leading, spacing: 8) {
                                Text("Quasars Discharged")
                                    .font(.headline)
                                
                                if let stats = viewModel.energyStatistics {
                                    Text("\(stats.totalQuasarsDischarged, specifier: "%.1f") kWh")
                                } else {
                                    Text("N/A")
                                }
                            }
                        }
                        
                        // Statistics Widget (navigates to the Detail screen)
                        NavigationLink(destination: ReportDetailView()) {
                            widgetCard {
                                VStack(alignment: .leading, spacing: 8) {
                                    Text("Statistics")
                                        .font(.headline)
                                    
                                    if let stats = viewModel.energyStatistics {
                                        Text("Grid: \(stats.gridPercentage, specifier: "%.1f")%")
                                        Text("PV: \(stats.pvPercentage, specifier: "%.1f")%")
                                        Text("Quasars Charged: \(stats.quasarsChargedPercentage, specifier: "%.1f")%")
                                    } else {
                                        Text("N/A")
                                    }
                                }
                            }
                        }
                    }
                    .padding()
                }
            }
            .navigationTitle("Dashboard")
            .onAppear {
                viewModel.loadData()
            }
        }
    }
    
    // A helper view that styles the widget as a card
    @ViewBuilder
    private func widgetCard<Content: View>(content: () -> Content) -> some View {
        content()
            .padding()
            .frame(minWidth: 0, maxWidth: .infinity, minHeight: 150)
            .background(Color(.systemCyan).opacity(0.1))
            .cornerRadius(12)
            .shadow(color: Color.black.opacity(0.2), radius: 4, x: 4, y: 4)
    }
}
