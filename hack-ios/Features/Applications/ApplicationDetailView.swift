//
//  ApplicationDetialView.swift
//  hack-ios
//
//  Created by Ally Keightley on 7/10/26.
//

import SwiftUI

struct ApplicationDetailView: View {
    let application: Application

    @State
    private var isShowingEditor = false

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 24) {
                if let hackathon = application.hackathon {
                    VStack(alignment: .leading, spacing: 8) {
                        Text(hackathon.name)
                            .font(.largeTitle.bold())

                        Text(hackathon.organizer)
                            .foregroundStyle(.secondary)

                        Text(hackathon.location)
                            .font(.subheadline)
                            .foregroundStyle(.secondary)
                    }

                    StatusBadge(status: application.status)

                    Divider()

                    VStack(alignment: .leading, spacing: 8) {
                        Text("Application")
                            .font(.title2.bold())

                        LabeledContent(
                            "Status",
                            value: application.status.displayName
                        )

                        if let appliedAt = application.appliedAt {
                            LabeledContent {
                                Text(
                                    appliedAt.formatted(
                                        date: .abbreviated,
                                        time: .omitted
                                    )
                                )
                            } label: {
                                Text("Applied")
                            }
                        }
                    }

                    VStack(alignment: .leading, spacing: 8) {
                        Text("Notes")
                            .font(.title2.bold())

                        if application.notes.isEmpty {
                            Text("No notes added yet.")
                                .foregroundStyle(.secondary)
                        } else {
                            Text(application.notes)
                        }
                    }

                    if let deadline = hackathon.applicationDeadline {
                        VStack(alignment: .leading, spacing: 8) {
                            Text("Deadline")
                                .font(.title2.bold())

                            Text(
                                deadline.formatted(
                                    date: .long,
                                    time: .omitted
                                )
                            )
                        }
                    }
                } else {
                    ContentUnavailableView(
                        "Hackathon Unavailable",
                        systemImage: "exclamationmark.triangle",
                        description: Text(
                            "This application is no longer connected to a hackathon."
                        )
                    )
                }
            }
            .padding()
        }
        .navigationTitle("Application")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button("Edit") {
                    isShowingEditor = true
                }
            }
        }
        .sheet(isPresented: $isShowingEditor) {
            ApplicationEditorView(application: application)
        }
    }
}
