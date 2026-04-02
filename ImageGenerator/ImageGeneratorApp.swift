//
//  ImageGeneratorApp.swift
//  ImageGenerator
//
//  Created by Александра Савичева on 31.03.2026.
//

import SwiftUI

@main
struct ImageGeneratorApp: App {
    @State var appManager = AppManager()
    
    var body: some Scene {
        Window("ImageGenerator", id: "main") {
            ContentView()
                .environment(appManager)
        }
        .commands {
            CommandMenu("Actions") {
                ImageButtonsView(displayForMenu: true)
                    .environment(appManager)
                
                InitImageView(displayForMenu: true)
                    .environment(appManager)
            }
        }
    }
}
