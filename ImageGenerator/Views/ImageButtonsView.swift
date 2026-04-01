//
//  ImageButtonsView.swift
//  ImageGenerator
//
//  Created by Александра Савичева on 01.04.2026.
//

import SwiftUI

struct ImageButtonsView: View {
    @Environment(AppManager.self) private var appManager
    var displayForMenu: Bool = false
    
    var body: some View {
        if displayForMenu {
            Group {
                regenerateButton
                shareButton
                imagePlaygroundButton
            }
        } else {
            regenerateButton
                .toolbar {
                    ToolbarItem {
                        imagePlaygroundButton
                    }
                    
                    ToolbarItem(placement: .primaryAction) {
                        shareButton
                    }
                }
        }
    }
    
    private var regenerateButton: some View {
        Button("Regenerate", systemImage: "arrow.clockwise") {
            appManager.generateImage()
        }
        .buttonStyle(.plain)
        .font(.footnote)
        .keyboardShortcut("r", modifiers: .command)
        .disabled(!appManager.showKitchen)
    }
    
    private var imagePlaygroundButton: some View {
        Button("Edit in Image Playground", systemImage: "apple.image.playground") {
            appManager.showPlayground = true
        }
        .keyboardShortcut("i", modifiers: [.command, .shift])
        .disabled(appManager.currentImage == nil)
    }
    
    @ViewBuilder
    private var shareButton: some View {
        if let image = appManager.currentImage {
            let preview = SharePreview("My Recipe", image: image)
            ShareLink(item: image, preview: preview) {
                Label("Share", systemImage: "square.and.arrow.up")
            }
            .buttonStyle(.borderedProminent)
        }
    }
}

#Preview {
    ImageButtonsView()
}
