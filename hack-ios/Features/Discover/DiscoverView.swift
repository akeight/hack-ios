//
//  DiscoverView.swift
//  hack-ios
//
//  Created by Ally Keightley on 7/10/26.
//

import SwiftUI
import SwiftData

struct DiscoverView: View {
    @Environment(\.modelContext)
    private var modelContext

    @Query(
        sort: \Hackathon.startDate,
        order: .forward
    )
    private var hackathons: [Hackathon]

    @State
    private var loadingError: String?

    var body: some View {
        NavigationStack {
            Group {
                if let loadingError {
                    ContentUnavailableView(
                        "Unable to Load Hackathons",
                        systemImage:
                            "exclamationmark.triangle",
                        description: Text(loadingError)
                    )
                } else if hackathons.isEmpty {
                    ProgressView(
                        "Loading hackathons…"
                    )
                    .tint(.brandOrange)
                } else {
                    ScrollView {
                        LazyVStack(
                            alignment: .leading,
                            spacing: BrandMetrics.sectionSpacing
                        ) {
                            SectionEyebrow("Upcoming hackathons")
                                .padding(.horizontal, 4)

                            ForEach(hackathons) { hackathon in
                                NavigationLink {
                                    HackathonDetailView(
                                        hackathon: hackathon
                                    )
                                } label: {
                                    HackathonCard(
                                        hackathon: hackathon
                                    )
                                }
                                .buttonStyle(.plain)
                            }
                        }
                        .padding(BrandMetrics.screenPadding)
                    }
                }
            }
            .brandBackground()
            .navigationTitle("Discover")
            .task {
                await loadSampleDataIfNeeded()
            }
        }
    }

    @MainActor
    private func loadSampleDataIfNeeded() async {
        guard hackathons.isEmpty else {
            return
        }

        do {
            try SampleDataService
                .insertSampleData(
                    into: modelContext
                )
        } catch {
            loadingError = error.localizedDescription
        }
    }
}
