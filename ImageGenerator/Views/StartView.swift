//
//  StartView.swift
//  ImageGenerator
//
//  Created by Александра Савичева on 31.03.2026.
//

import SwiftUI
import ImagePlayground

struct StartView: View {
    @Environment(AppManager.self) private var appManager
    
    var body: some View {
        @Bindable var imageGenerator = appManager.imageGenerator
        
        VStack(alignment: .leading, spacing: 16) {
            Text("Create a unique dish")
                .font(.largeTitle.weight(.semibold))
                .frame(maxWidth: .infinity, alignment: .center)
            
            Label("Choose a dish", systemImage: "fork.knife")
                .padding(.top, 8)
            Picker("Recipes", selection: $imageGenerator.recipe) {
                ForEach(ImageGenerator.recipes, id: \.description) { recipe in
                    Text(recipe)
                        .tag(recipe)
                }
            }
            
            Label("Choose an image style", systemImage: "paintpalette.fill")
                .padding(.top, 8)
            Picker("Styles", selection: $imageGenerator.style) {
                ForEach(ImageGenerator.styles) { style in
                    Text(style.id.capitalized)
                        .tag(style)
                }
            }
            
            Spacer()
        }
        .toolbar {
            ToolbarItem(placement: .primaryAction) {
                Button("Generate Image") {
                    appManager.generateImage()
                }
                .disabled(imageGenerator.style == nil)
                .buttonStyle(.glassProminent)
            }
        }
        .pickerStyle(.segmented)
        .labelsHidden()
        .frame(width: ImageGenerator.imageSize)
        .padding()
    }
}

#Preview {
    StartView()
        .previewEnvironment()
}
