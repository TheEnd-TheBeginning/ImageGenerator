//
//  ContentView.swift
//  ImageGenerator
//
//  Created by Александра Савичева on 31.03.2026.
//

import SwiftUI

struct ContentView: View {
    @Environment(AppManager.self) private var appManager
    
    var body: some View {
        VStack {
            if let image = appManager.currentImage {
                Image(nsImage: image)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
            } else {
                StartView()
            }
        }
        .overlay {
            if appManager.isGenerating {
                loadingView()
            }
        }
    }
    
    private func loadingView() -> some View {
        HStack(spacing: 8) {
            ProgressView()
            Text("Generating image...")
        }
        .padding()
        .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 16))
    }
}

#Preview {
    ContentView()
        .previewEnvironment()
}
