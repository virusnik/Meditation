//
//  meditationApp.swift
//  meditation
//
//  Created by Sergio Veliz on 18.05.2023.
//

import SwiftUI

@main
struct meditationApp: App {
    
    @StateObject var launchScreenState = LaunchScreenStateManager()
    
    var body: some Scene {
        WindowGroup {
            ZStack {
                ContentView()
                
                if launchScreenState.state != .finished {
                    LaunchScreenView()
                }
            }.environmentObject(launchScreenState)
        }
    }
}
