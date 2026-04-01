//
//  PhotoPickerView.swift
//  ImageGenerator
//
//  Created by Александра Савичева on 01.04.2026.
//

import SwiftUI
import PhotosUI

struct PhotoPickerView: View {
    @Environment(AppManager.self) private var appManager
    @State private var newImage: PhotosPickerItem?
    
    var body: some View {
        VStack(alignment: .center) {
            Text("Initial Image")
                .font(.title2.bold())
            
            HStack {
                PhotosPicker(selection: $newImage) {
                    Label("Choose Image", systemImage: "plus.circle.fill")
                }
                .onChange(of: newImage) {
                    appManager.setInitImage(initImage: newImage)
                }
                
                Button {
                    appManager.removeInitImage()
                } label: {
                    Label("Remove Image", systemImage: "minus.circle.fill")
                }
            }
            
            if let initImage = appManager.imageGenerator.initImage {
                Image(nsImage: initImage)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: ImageGenerator.imageSize, height: ImageGenerator.imageSize)
            }
        }
    }
}

#Preview {
    PhotoPickerView()
        .previewEnvironment()
}
