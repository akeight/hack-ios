//
//  SettingsView.swift
//  hack-ios
//
//  Created by Ally Keightley on 7/10/26.
//

import SwiftUI
import UserNotifications

struct SettingsView: View {
    @AppStorage(AppThemeStorage.key)
    private var appTheme: AppTheme = .system

    @State
    private var notificationStatusText =
        "Checking permission…"

    var body: some View {
        NavigationStack {
            Form {
                Section {
                    Picker(
                        "Theme",
                        selection: $appTheme
                    ) {
                        ForEach(AppTheme.allCases) { theme in
                            Label(
                                theme.displayName,
                                systemImage: theme.symbolName
                            )
                            .tag(theme)
                        }
                    }
                    .pickerStyle(.segmented)
                } header: {
                    SectionEyebrow("Appearance")
                } footer: {
                    Text(
                        "Choose how HackHQ looks. System follows your device setting."
                    )
                }

                Section {
                    LabeledContent(
                        "Permission",
                        value: notificationStatusText
                    )

                    Button("Request Notification Permission") {
                        Task {
                            await requestPermission()
                        }
                    }
                    .tint(.brandOrange)
                } header: {
                    SectionEyebrow("Notifications")
                }

                Section {
                    LabeledContent(
                        "App",
                        value: "HackHQ"
                    )

                    LabeledContent(
                        "Version",
                        value: appVersion
                    )
                } header: {
                    SectionEyebrow("About")
                }

                Section {
                    VStack(spacing: 8) {
                        Image("AppLogo")
                            .resizable()
                            .scaledToFit()
                            .frame(height: 44)
                            .clipShape(
                                RoundedRectangle(
                                    cornerRadius: 10,
                                    style: .continuous
                                )
                            )

                        Text("HackHQ \(appVersion)")
                            .font(.caption)
                            .foregroundStyle(Color.brandInkSecondary)
                    }
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 8)
                    .listRowBackground(Color.clear)
                }
            }
            .scrollContentBackground(.hidden)
            .brandBackground()
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
