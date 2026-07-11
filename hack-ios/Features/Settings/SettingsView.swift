//
//  SettingsView.swift
//  hack-ios
//
//  Created by Ally Keightley on 7/10/26.
//

import SwiftUI
import UserNotifications

struct SettingsView: View {
    @State
    private var notificationStatusText =
        "Checking permission…"

    var body: some View {
        NavigationStack {
            Form {
                Section("Notifications") {
                    LabeledContent(
                        "Permission",
                        value: notificationStatusText
                    )

                    Button("Request Notification Permission") {
                        Task {
                            await requestPermission()
                        }
                    }
                }

                Section("About") {
                    LabeledContent(
                        "App",
                        value: "HackHQ"
                    )

                    LabeledContent(
                        "Version",
                        value: appVersion
                    )
                }
            }
            .navigationTitle("Settings")
            .task {
                await loadNotificationStatus()
            }
        }
    }

    @MainActor
    private func requestPermission() async {
        do {
            _ = try await NotificationService
                .requestAuthorization()

            await loadNotificationStatus()
        } catch {
            notificationStatusText =
                "Unable to request permission"
        }
    }

    @MainActor
    private func loadNotificationStatus() async {
        let settings =
            await UNUserNotificationCenter
                .current()
                .notificationSettings()

        switch settings.authorizationStatus {
        case .authorized:
            notificationStatusText = "Allowed"

        case .denied:
            notificationStatusText = "Denied"

        case .notDetermined:
            notificationStatusText = "Not Requested"

        case .provisional:
            notificationStatusText = "Provisional"

        case .ephemeral:
            notificationStatusText = "Temporary"

        @unknown default:
            notificationStatusText = "Unknown"
        }
    }

    private var appVersion: String {
        Bundle.main.object(
            forInfoDictionaryKey:
                "CFBundleShortVersionString"
        ) as? String ?? "1.0"
    }
}
