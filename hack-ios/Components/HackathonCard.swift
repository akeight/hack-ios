//
//  HackathonCard.swift
//  hack-ios
//
//  Created by Ally Keightley on 7/10/26.
//

import SwiftUI

struct HackathonCard: View {
    let hackathon: Hackathon

    var body: some View {
        VStack(
            alignment: .leading,
            spacing: 12
        ) {
            HStack(alignment: .top) {
                VStack(alignment: .leading, spacing: 4) {
                    Text(hackathon.name)
                        .font(.headline)

                    Text(hackathon.organizer)
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                }

                Spacer()

                if hackathon.isFeatured {
                    Image(systemName: "sparkles")
                        .foregroundStyle(.orange)
                }
            }

            Label(
                hackathon.location,
                systemImage: "mappin.and.ellipse"
            )
            .font(.subheadline)

            Label(
                dateRangeText,
                systemImage: "calendar"
            )
            .font(.subheadline)

            if let deadline = hackathon.applicationDeadline {
                let formattedDeadline = deadline.formatted(
                    date: .abbreviated,
                    time: .omitted
                )

                Label(
                    "Apply by \(formattedDeadline)",
                    systemImage: "clock"
                )
                .font(.subheadline)
                .foregroundStyle(.secondary)
            }

            if !hackathon.tags.isEmpty {
                ScrollView(.horizontal) {
                    HStack {
                        ForEach(hackathon.tags) { tag in
                            TagChip(name: tag.name)
                        }
                    }
                }
                .scrollIndicators(.hidden)
            }
        }
        .padding()
        .background(.regularMaterial)
        .clipShape(
            RoundedRectangle(cornerRadius: 20)
        )
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
}
