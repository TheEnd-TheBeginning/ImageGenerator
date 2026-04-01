//
//  AppManager.swift
//  ImageGenerator
//
//  Created by Александра Савичева on 31.03.2026.
//

import SwiftUI
import ImagePlayground
import PhotosUI

@Observable
class AppManager {
    let imageGenerator = ImageGenerator()
    var currentImage: NSImage?
    var showPlayground: Bool = false
    
    private(set) var error: Error?
    private(set) var isGenerating = false
    private var task: Task<Void, Never>?
    private var initImageTask: Task<Void, Never>?
    
    func generateImage() {
        error = nil
        isGenerating = true
        task?.cancel()
        
        task = Task {
            do {
                let generatedImage = try await imageGenerator.generate()
                currentImage = NSImage(cgImage: generatedImage.cgImage, size: .zero)
                isGenerating = false
            } catch {
                do {
                    try Task.checkCancellation()
                    self.error = error
                    isGenerating = false
                } catch {
                    // Task cancelled
                }
            }
        }
    }
    
    func reset() {
        imageGenerator.resetGenerator()
        currentImage = nil
        error = nil
        isGenerating = false
        task?.cancel()
        initImageTask?.cancel()
    }
    
    var showKitchen: Bool {
        currentImage != nil || isGenerating
    }
    
    func add(ingredient: String) {
        imageGenerator.ingredients.append(ingredient)
        generateImage()
    }
    
    
    func setInitImage(initImage: PhotosPickerItem?) {
        guard let initImage else { return }
        initImageTask?.cancel()
        
        initImageTask = Task {
            if let imageData = try? await initImage.loadTransferable(type: Data.self) {
                imageGenerator.initImage = NSImage(data: imageData)
            }
        }
    }
    
    func removeInitImage() {
        imageGenerator.initImage = nil
    }
    
    func remove(ingredient: String) {
        if let index = imageGenerator.ingredients.firstIndex(where: { $0 == ingredient }) {
            imageGenerator.ingredients.remove(at: index)
        }
        generateImage()
    }
}

extension View {
    func previewEnvironment(generateImage: Bool = false) -> some View {
        let appManager = AppManager()
        appManager.imageGenerator.ingredients.append("Strawberry")
        return environment(appManager)
            .onAppear {
                if generateImage {
                    appManager.imageGenerator.style = .animation
                    appManager.generateImage()
                }
            }
    }
}
