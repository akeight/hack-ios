//
//  ReminderEditorView.swift
//  hack-ios
//
//  Created by Ally Keightley on 7/10/26.
//

import SwiftUI
import SwiftData

struct ReminderEditorView: View {
    @Environment(\.dismiss)
    private var dismiss

    @Environment(\.modelContext)
    private var modelContext

    let hackathon: Hackathon

    @State
    private var selectedType: ReminderType

    @State
    private var reminderDate: Date

    @State
    private var customTitle = ""

    @State
    private var errorMessage: String?

    @State
    private var isSaving = false

    init(hackathon: Hackathon) {
        self.hackathon = hackathon

        _selectedType = State(
            initialValue: .applicationDeadline
        )

        let defaultDate =
            hackathon.applicationDeadline?
                .addingTimeInterval(-86_400)
            ?? Calendar.current.date(
                byAdding: .day,
                value: 1,
                to: .now
            )
            ?? .now

        _reminderDate = State(
            initialValue: max(defaultDate, .now.addingTimeInterval(60))
        )
    }

    var body: some View {
        NavigationStack {
            Form {
                Section("Reminder") {
                    Picker(
                        "Type",
                        selection: $selectedType
                    ) {
                        ForEach(ReminderType.allCases) { type in
                            Text(type.displayName)
                                .tag(type)
                        }
                    }

                    DatePicker(
                        "Remind me",
                        selection: $reminderDate,
                        in: Date.now...,
                        displayedComponents: [.date, .hourAndMinute]
                    )

                    if selectedType == .custom {
                        TextField(
                            "Reminder title",
                            text: $customTitle
                        )
                    }
                }

                if let errorMessage {
                    Section {
                        Text(errorMessage)
                            .foregroundStyle(.red)
                    }
                }
            }
            .navigationTitle("Add Reminder")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") {
                        dismiss()
                    }
                }

                ToolbarItem(placement: .confirmationAction) {
                    Button("Save") {
                        Task {
                            await saveReminder()
                        }
                    }
                    .disabled(
                        isSaving ||
                        (
                            selectedType == .custom &&
                            customTitle.trimmingCharacters(
                                in: .whitespacesAndNewlines
                            ).isEmpty
                        )
                    )
                }
            }
        }
    }

    @MainActor
    private func saveReminder() async {
        isSaving = true
        errorMessage = nil

        do {
            let authorized =
                try await NotificationService
                    .requestAuthorization()

            guard authorized else {
                errorMessage =
                    "Notifications are not currently allowed."
                isSaving = false
                return
            }

            let reminder = DeadlineReminder(
                reminderDate: reminderDate,
                type: selectedType,
                customTitle: cleanedCustomTitle,
                hackathon: hackathon
            )

            let notificationID = reminder.id.uuidString

            try await NotificationService.scheduleReminder(
                id: notificationID,
                title: notificationTitle,
                body: notificationBody,
                date: reminderDate
            )

            reminder.notificationIdentifier =
                notificationID

            modelContext.insert(reminder)
            hackathon.reminders.append(reminder)

            dismiss()
        } catch {
            errorMessage = error.localizedDescription
            isSaving = false
        }
    }

    private var cleanedCustomTitle: String? {
        let cleaned = customTitle.trimmingCharacters(
            in: .whitespacesAndNewlines
        )

        return cleaned.isEmpty ? nil : cleaned
    }

    private var notificationTitle: String {
        if selectedType == .custom {
            return cleanedCustomTitle ?? "HackHQ Reminder"
        }

        return selectedType.displayName
    }

    private var notificationBody: String {
        "\(hackathon.name) — \(selectedType.displayName)"
    }
}
