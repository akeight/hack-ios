//
//  SavedHackathonsView.swift
//  hack-ios
//
//  Created by Ally Keightley on 7/10/26.
//

import SwiftUI
import SwiftData

struct SavedHackathonsView: View {
    @Query(
        filter: #Predicate<Hackathon> {
            $0.isSaved == true
        },
        sort: \Hackathon.startDate,
        order: .forward
    )
    private var savedHackathons: [Hackathon]

    var body: some View {
        NavigationStack {
            Group {
                if savedHackathons.isEmpty {
                    ContentUnavailableView(
                        "No Saved Hackathons",
                        systemImage: "bookmark",
                        description: Text(
                            "Save a hackathon to find it here."
                        )
                    )
                } else {
                    List(savedHackathons) { hackathon in
                        NavigationLink {
                            HackathonDetailView(
                                hackathon: hackathon
                            )
                        } label: {
                            VStack(
                                alignment: .leading,
                                spacing: 6
                            ) {
                                Text(hackathon.name)
                                    .font(.brandHeadline)
                                    .foregroundStyle(Color.brandInk)

                                Text(hackathon.location)
                                    .font(.subheadline)
                                    .foregroundStyle(Color.brandInkSecondary)

                                Text(dateText(for: hackathon))
                                    .font(.caption)
                                    .foregroundStyle(Color.brandOrange)
                            }
                            .padding(.vertical, 4)
                        }
                        .listRowBackground(Color.brandSurface)
                    }
                    .scrollContentBackground(.hidden)
                }
            }
            .brandBackground()
            .navigationTitle("Saved")
        }
    }

    private func dateText(
        for hackathon: Hackathon
    ) -> String {
        switch (
            hackathon.startDate,
            hackathon.endDate
        ) {
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
}
