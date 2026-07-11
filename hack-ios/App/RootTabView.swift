//
//  RootTabView.swift
//  hack-ios
//
//  Created by Ally Keightley on 7/10/26.
//

import SwiftUI

struct RootTabView: View {
    var body: some View {
        TabView {
            DiscoverView()
                .tabItem {
                    Label(
                        "Discover",
                        systemImage: "sparkles"
                    )
                }

            SavedHackathonsView()
                .tabItem {
                    Label(
                        "Saved",
                        systemImage: "bookmark"
                    )
                }

            MyHackathonsView()
                .tabItem {
                    Label(
                        "My Hackathons",
                        systemImage: "calendar"
                    )
                }

            SettingsView()
                .tabItem {
                    Label(
                        "Settings",
                        systemImage: "gearshape"
                    )
                }
        }
    }
}
