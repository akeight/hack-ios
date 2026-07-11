//
//  MyHackathonsView.swift
//  hack-ios
//
//  Created by Ally Keightley on 7/10/26.
//

import SwiftUI
import SwiftData

struct MyHackathonsView: View {
    @Environment(\.modelContext)
    private var modelContext

    @Query(
        sort: \Application.updatedAt,
        order: .reverse
    )
    private var applications: [Application]

    var body: some View {
        NavigationStack {
            Group {
                if applications.isEmpty {
                    ContentUnavailableView(
                        "Nothing Tracked Yet",
                        systemImage: "checklist",
                        description: Text(
                            "Track a hackathon to manage your application."
                        )
                    )
                } else {
                    List {
                        ForEach(applications) { application in
                            if let hackathon = application.hackathon {
                                NavigationLink {
                                    ApplicationDetailView(
                                        application: application
                                    )
                                } label: {
                                    VStack(
                                        alignment: .leading,
                                        spacing: 8
                                    ) {
                                        Text(hackathon.name)
                                            .font(.brandHeadline)
                                            .foregroundStyle(Color.brandInk)

                                        Text(hackathon.location)
                                            .font(.subheadline)
                                            .foregroundStyle(Color.brandInkSecondary)

                                        StatusBadge(
                                            status: application.status
                                        )
                                    }
                                    .padding(.vertical, 4)
                                }
                                .listRowBackground(Color.brandSurface)
                            }
                        }
                        .onDelete(perform: deleteApplications)
                    }
                    .scrollContentBackground(.hidden)
                }
            }
            .brandBackground()
            .navigationTitle("My Hackathons")
        }
    }

    private func deleteApplications(
        at offsets: IndexSet
    ) {
        for index in offsets {
            let application = applications[index]

            application.hackathon?.application = nil
            modelContext.delete(application)
        }
    }
}
