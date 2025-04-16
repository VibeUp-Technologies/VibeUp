//
//  VibeUpApp.swift
//  VibeUp
//
//  Created by Nikita Lizogubov on 13.04.2025.
//

import SwiftUI

@main
struct VibeUpApp: App {
    
    private let coordinator = AppCoordinator()
    
    var body: some Scene {
        WindowGroup {
            AppCoordinatorView(coordinator: coordinator)
        }
    }
}
