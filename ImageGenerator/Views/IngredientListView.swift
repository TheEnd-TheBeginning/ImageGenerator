//
//  IngredientListView.swift
//  ImageGenerator
//
//  Created by Александра Савичева on 01.04.2026.
//

import SwiftUI

struct IngredientListView: View {
    @Environment(AppManager.self) private var appManager
    @State private var newIngredient: String = ""
    
    var body: some View {
        VStack(alignment: .leading) {
            TextField("Add Ingredients (optional)", text: $newIngredient)
                .textFieldStyle(.roundedBorder)
                .onSubmit {
                    appManager.add(ingredient: newIngredient)
                    newIngredient = ""
                }
            
            if !appManager.imageGenerator.ingredients.isEmpty {
                Text("Added Ingredients")
                    .font(.body.bold())
                    .padding(.vertical, 8)
                
                LazyVGrid(columns: [GridItem(), GridItem()]) {
                    ForEach(appManager.imageGenerator.ingredients, id: \.description) { ingredient in
                        field(ingredient: ingredient)
                    }
                }
            }
        }
    }
    
    private func field(ingredient: String) -> some View {
        HStack {
            Text(ingredient.capitalized)
                .lineLimit(1)
            
            Spacer()
            
            Button {
                appManager.remove(ingredient: ingredient)
            } label: {
                Image(systemName: "xmark.circle.fill")
            }
            .buttonStyle(.plain)
        }
        .padding(.horizontal, 8)
        .padding(.vertical, 4)
        .foregroundStyle(.white)
        .background(Color.indigo.opacity(0.9), in: Capsule())
    }
}

#Preview {
    IngredientListView()
        .previewEnvironment()
        .padding()
}
