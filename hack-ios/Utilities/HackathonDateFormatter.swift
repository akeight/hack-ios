//
//  HackathonDateFormatter.swift
//  hack-ios
//
//  Created by Ally Keightley on 7/10/26.
//

import Foundation

enum HackathonDateFormatter {
    static func dateRange(
        startDate: Date?,
        endDate: Date?
    ) -> String {
        switch (startDate, endDate) {
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

    static func applicationDeadline(
        _ deadline: Date?
    ) -> String? {
        guard let deadline else {
            return nil
        }

        let formattedDate = deadline.formatted(
            date: .abbreviated,
            time: .omitted
        )

        return "Apply by \(formattedDate)"
    }
}
