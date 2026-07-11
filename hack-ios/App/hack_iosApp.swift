//
//  hack-iosApp.swift
//  hack-ios
//
//  Created by Ally Keightley on 7/10/26.
//

import SwiftUI
import SwiftData

@main
struct hack_iosApp: App {
    var body: some Scene {
        WindowGroup {
            RootContainerView()
        }
        .modelContainer(
            for: [
                Hackathon.self,
                Tag.self,
                Application.self,
                DeadlineReminder.self
            ]
        )
    }
}
