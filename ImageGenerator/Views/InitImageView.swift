//
//  PhotoPickerView.swift
//  ImageGenerator
//
//  Created by Александра Савичева on 01.04.2026.
//

import SwiftUI
import PhotosUI

struct InitImageView: View {
    @Environment(AppManager.self) private var appManager
    @State private var newImage: PhotosPickerItem?
    var displayForMenu: Bool = false
    
    var body: some View {
        if displayForMenu {
            chooseImageButton
            
            removeImageButton
                .disabled(appManager.imageGenerator.initImage == nil)
        } else {
            VStack(alignment: .center) {
                Text("Initial Image")
                    .font(.title2.bold())
                
                HStack {
                    chooseImageButton
                    
                    if appManager.imageGenerator.initImage != nil {
                        removeImageButton
                    }
                    
                    if appManager.isInitImageLoading {
                        ProgressView()
                            .frame(alignment: .trailing)
                    }
                }
                
                if let initImage = appManager.imageGenerator.initImage {
                    Image(nsImage: initImage)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: ImageGenerator.imageSize, height: ImageGenerator.imageSize)
                        .clipShape(RoundedRectangle(cornerRadius: 16))
                        .contentShape(RoundedRectangle(cornerRadius: 16).inset(by: 10))
                }
            }
        }
    }
    
    private var chooseImageButton: some View {
        PhotosPicker(selection: $newImage) {
            Label("Choose Image", systemImage: "plus.circle.fill")
        }
        .onChange(of: newImage) {
            if newImage != nil {
                appManager.setInitImage(initImage: newImage)
                newImage = nil
            }
        }
    }
    
    private var removeImageButton: some View {
        Button {
            appManager.removeInitImage()
        } label: {
            Label("Remove Image", systemImage: "minus.circle.fill")
        }
    }
}

#Preview {
    InitImageView()
        .previewEnvironment()
}
