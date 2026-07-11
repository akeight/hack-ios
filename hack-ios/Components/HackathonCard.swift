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
                        .font(.brandHeadline)
                        .foregroundStyle(Color.brandInk)

                    Text(hackathon.organizer)
                        .font(.brandSubheadline)
                        .foregroundStyle(Color.brandInkSecondary)
                }

                Spacer()

                if hackathon.isFeatured {
                    Image(systemName: "sparkles")
                        .foregroundStyle(Color.brandOrange)
                }
            }

            Label(
                hackathon.location,
                systemImage: "mappin.and.ellipse"
            )
            .font(.subheadline)
            .foregroundStyle(Color.brandInk)

            Label(
                dateRangeText,
                systemImage: "calendar"
            )
            .font(.subheadline)
            .foregroundStyle(Color.brandInk)

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
                .foregroundStyle(Color.brandOrange)
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
        .brandCard(featured: hackathon.isFeatured)
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
