//
//  ApplicationEditorView.swift
//  hack-ios
//
//  Created by Ally Keightley on 7/10/26.
//

import SwiftUI

struct ApplicationEditorView: View {
    @Environment(\.dismiss)
    private var dismiss

    let application: Application

    @State
    private var selectedStatus: ApplicationStatus

    @State
    private var notes: String

    @State
    private var hasAppliedDate: Bool

    @State
    private var appliedAt: Date

    init(application: Application) {
        self.application = application

        _selectedStatus = State(
            initialValue: application.status
        )

        _notes = State(
            initialValue: application.notes
        )

        _hasAppliedDate = State(
            initialValue: application.appliedAt != nil
        )

        _appliedAt = State(
            initialValue: application.appliedAt ?? .now
        )
    }

    var body: some View {
        NavigationStack {
            Form {
                Section("Status") {
                    Picker(
                        "Application Status",
                        selection: $selectedStatus
                    ) {
                        ForEach(ApplicationStatus.allCases) { status in
                            Text(status.displayName)
                                .tag(status)
                        }
                    }
                }

                Section("Application Date") {
                    Toggle(
                        "Include application date",
                        isOn: $hasAppliedDate
                    )

                    if hasAppliedDate {
                        DatePicker(
                            "Applied",
                            selection: $appliedAt,
                            displayedComponents: .date
                        )
                    }
                }

                Section("Notes") {
                    TextField(
                        "Add preparation notes, links, or updates",
                        text: $notes,
                        axis: .vertical
                    )
                    .lineLimit(5...12)
                }
            }
            .navigationTitle("Edit Application")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") {
                        dismiss()
                    }
                }

                ToolbarItem(placement: .confirmationAction) {
                    Button("Save") {
                        saveChanges()
                    }
                }
            }
        }
    }

    private func saveChanges() {
        application.status = selectedStatus
        application.notes = notes
        application.appliedAt = hasAppliedDate
            ? appliedAt
            : nil
        application.updatedAt = .now

        dismiss()
    }
}
