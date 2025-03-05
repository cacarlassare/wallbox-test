//
//  ErrorView.swift
//  wallbox-test
//
//  Created by Cristian Carlassare on 04/03/2025.
//

import SwiftUI

struct ErrorView: View {
    let errorMessage: String
    let retryAction: () -> Void
    
    var body: some View {
        
        VStack(spacing: 16) {
            
            Text("Error: \(errorMessage)")
                .foregroundColor(.red)
                .multilineTextAlignment(.center)
            
            Button("Retry", action: retryAction)
                .buttonStyle(.borderedProminent)
        }
        .padding()
    }
}
