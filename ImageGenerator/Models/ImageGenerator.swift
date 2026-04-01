//
//  ImageGenerator.swift
//  ImageGenerator
//
//  Created by Александра Савичева on 31.03.2026.
//

import Foundation
import ImagePlayground
import SwiftUI

@Observable
class ImageGenerator {
    var recipe = ImageGenerator.defaultRecipe
    var style: ImagePlaygroundStyle?
    var ingredients: [String] = []
    var initImage: NSImage?
    
    var concepts: [ImagePlaygroundConcept] {
        var playgroundConcepts = [ImagePlaygroundConcept.text(recipe)]
        for ingridient in ingredients {
            playgroundConcepts.append(.text(ingridient))
        }
        
        if let initImage = initImage?.cgImage(forProposedRect: nil, context: nil, hints: nil) {
            playgroundConcepts.append(.image(initImage))
        }
        return playgroundConcepts
    }
    
    func generate() async throws -> ImageCreator.CreatedImage {
        guard let style else { throw ImageCreator.Error.creationFailed }
        
        let imageCreator = try await ImageCreator()
        let images = imageCreator.images(for: concepts, style: style, limit: 1)
        
        for try await image in images {
            return image
        }
        
        throw ImageCreator.Error.creationFailed
    }
    
    func resetGenerator() {
        recipe = ImageGenerator.defaultRecipe
        style = nil
        initImage = nil
        ingredients.removeAll()
    }
}

extension ImageGenerator {
    static let recipes = ["Salad", "Sandwich", "Ice Cream"]
    static let styles: [ImagePlaygroundStyle] = [
        .animation,
        .illustration,
        .sketch
    ]
    
    static let imageSize: CGFloat = 256
    private static let defaultRecipe = recipes[0]
}
