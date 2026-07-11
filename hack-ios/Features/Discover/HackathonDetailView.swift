//
//  HackathonDetailView.swift
//  hack-ios
//
//  Created by Ally Keightley on 7/10/26.
//

import SwiftUI
import SwiftData

struct HackathonDetailView: View {
    @Environment(\.modelContext)
    private var modelContext

    let hackathon: Hackathon

    @State
    private var isShowingReminderEditor = false

    var body: some View {
        ScrollView {
            VStack(
                alignment: .leading,
                spacing: 24
            ) {
                headerSection

                detailsSection

                if !hackathon.tags.isEmpty {
                    tagSection
                }

                descriptionSection

                actionSection

                if !hackathon.reminders.isEmpty {
                    reminderSection
                }
            }
            .padding()
        }
        .navigationBarTitleDisplayMode(.inline)
        .sheet(
            isPresented: $isShowingReminderEditor
        ) {
            ReminderEditorView(
                hackathon: hackathon
            )
        }
    }

    private var headerSection: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(hackathon.name)
                .font(.largeTitle.bold())

            Text(hackathon.organizer)
                .foregroundStyle(.secondary)
        }
    }

    private var detailsSection: some View {
        VStack(alignment: .leading, spacing: 12) {
            Label(
                hackathon.location,
                systemImage: "mappin.and.ellipse"
            )

            Label(
                hackathon.format.displayName,
                systemImage: "person.3"
            )

            Label(
                HackathonDateFormatter.dateRange(
                    startDate: hackathon.startDate,
                    endDate: hackathon.endDate
                ),
                systemImage: "calendar"
            )

            if let deadlineText =
                HackathonDateFormatter.applicationDeadline(
                    hackathon.applicationDeadline
                ) {
                Label(
                    deadlineText,
                    systemImage: "clock"
                )
            }
        }
    }

    private var tagSection: some View {
        ScrollView(.horizontal) {
            HStack {
                ForEach(hackathon.tags) { tag in
                    TagChip(name: tag.name)
                }
            }
        }
        .scrollIndicators(.hidden)
    }

    private var descriptionSection: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("About")
                .font(.title2.bold())

            Text(hackathon.summary)
        }
    }

    private var actionSection: some View {
        VStack(spacing: 12) {
            Button {
                hackathon.isSaved.toggle()
            } label: {
                Label(
                    hackathon.isSaved
                        ? "Saved"
                        : "Save Hackathon",
                    systemImage:
                        hackathon.isSaved
                        ? "bookmark.fill"
                        : "bookmark"
                )
                .frame(maxWidth: .infinity)
            }
            .buttonStyle(.borderedProminent)

            Button {
                trackHackathon()
            } label: {
                Label(
                    hackathon.application == nil
                        ? "Track Application"
                        : "Application Tracked",
                    systemImage: "checklist"
                )
                .frame(maxWidth: .infinity)
            }
            .buttonStyle(.bordered)
            .disabled(hackathon.application != nil)

            Button {
                isShowingReminderEditor = true
            } label: {
                Label(
                    "Add Reminder",
                    systemImage: "bell.badge"
                )
                .frame(maxWidth: .infinity)
            }
            .buttonStyle(.bordered)

            if let url = URL(
                string: hackathon.websiteURL
            ) {
                Link(destination: url) {
                    Label(
                        "Open Website",
                        systemImage: "safari"
                    )
                    .frame(maxWidth: .infinity)
                }
                .buttonStyle(.bordered)

                ShareLink(item: url) {
                    Label(
                        "Share Hackathon",
                        systemImage: "square.and.arrow.up"
                    )
                    .frame(maxWidth: .infinity)
                }
                .buttonStyle(.bordered)
            }
        }
    }

    private var reminderSection: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Reminders")
                .font(.title2.bold())

            ForEach(hackathon.reminders) { reminder in
                HStack {
                    VStack(alignment: .leading, spacing: 4) {
                        Text(
                            reminder.customTitle
                            ?? reminder.type.displayName
                        )
                        .font(.headline)

                        Text(
                            reminder.reminderDate.formatted(
                                date: .abbreviated,
                                time: .shortened
                            )
                        )
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                    }

                    Spacer()

                    Button(role: .destructive) {
                        deleteReminder(reminder)
                    } label: {
                        Image(systemName: "trash")
                    }
                }
            }
        }
    }

    private var dateRangeText: String {
        switch (hackathon.startDate, hackathon.endDate) {
        case let (startDate?, endDate?):
            let start = startDate.formatted(
                date: .abbreviated,
                time: .omitted
            )

            let end = endDate.formatted(
                date: .abbreviated,
                time: .omitted
            )

            return "\(start) – \(end)"

        case let (startDate?, nil):
            return startDate.formatted(
                date: .abbreviated,
                time: .omitted
            )

        case let (nil, endDate?):
            let end = endDate.formatted(
                date: .abbreviated,
                time: .omitted
            )

            return "Ends \(end)"

        case (nil, nil):
            return "Dates coming soon"
        }
    }

    private func trackHackathon() {
        guard hackathon.application == nil else {
            return
        }

        let application = Application(
            status: .interested,
            hackathon: hackathon
        )

        modelContext.insert(application)
        hackathon.application = application
    }

    private func deleteReminder(
        _ reminder: DeadlineReminder
    ) {
        if let notificationIdentifier =
            reminder.notificationIdentifier {
            NotificationService.cancelReminder(
                id: notificationIdentifier
            )
        }

        hackathon.reminders.removeAll {
            $0.id == reminder.id
        }

        modelContext.delete(reminder)
    }
}
