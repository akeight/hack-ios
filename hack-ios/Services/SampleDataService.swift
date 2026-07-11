//
//  SampleDataService.swift
//  hack-ios
//
//  Created by Ally Keightley on 7/10/26.
//

import Foundation
import SwiftData

enum SampleDataService {
    static func insertSampleData(
        into context: ModelContext
    ) throws {
        let existingHackathons = try context.fetch(
            FetchDescriptor<Hackathon>()
        )

        guard existingHackathons.isEmpty else {
            return
        }

        let calendar = Calendar.current

        func date(
            _ year: Int,
            _ month: Int,
            _ day: Int
        ) -> Date {
            calendar.date(
                from: DateComponents(
                    year: year,
                    month: month,
                    day: day
                )
            ) ?? .now
        }

        let virtualTag = Tag(name: "Virtual")
        let inPersonTag = Tag(name: "In Person")
        let studentTag = Tag(name: "Student")
        let aiTag = Tag(name: "AI")
        let featuredTag = Tag(name: "Featured")
        let globalTag = Tag(name: "Global")
        let healthcareTag = Tag(name: "Healthcare")
        let universityTag = Tag(name: "University")

        let hackathons = [
            Hackathon(
                id: UUID(
                    uuidString:
                        "fbc4968c-1522-4304-a25e-8b86f7003adb"
                ) ?? UUID(),
                name:
                    "Global Hack Week: Season Launch",
                summary:
                    "A virtual Global Hack Week event hosted by Major League Hacking, with swag and prizes.",
                websiteURL:
                    "https://ghw.mlh.io/",
                location: "Online",
                organizer: "Major League Hacking",
                startDate: date(2026, 7, 10),
                endDate: date(2026, 7, 16),
                applicationDeadline: date(2026, 7, 16),
                format: .virtual,
                isFeatured: false,
                tags: [
                    virtualTag,
                    globalTag
                ]
            ),

            Hackathon(
                id: UUID(
                    uuidString:
                        "c12023ad-aab3-44e5-beb7-d0956ef987c2"
                ) ?? UUID(),
                name: "Hack the 6ix 2026",
                summary:
                    "An in-person hackathon hosted by Hack the 6ix in Toronto.",
                websiteURL:
                    "https://hackthe6ix.com/",
                location: "Toronto, ON, Canada",
                organizer: "Hack the 6ix",
                startDate: date(2026, 7, 17),
                endDate: date(2026, 7, 19),
                applicationDeadline: date(2026, 7, 19),
                format: .inPerson,
                isFeatured: false,
                tags: [
                    inPersonTag,
                    studentTag
                ]
            ),

            Hackathon(
                id: UUID(
                    uuidString:
                        "0dd13a0e-b5ce-4dd0-a35c-f435b52ea23f"
                ) ?? UUID(),
                name: "Global Hack Week: Agents",
                summary:
                    "A virtual Global Hack Week focused on building with agents.",
                websiteURL:
                    "https://ghw.mlh.io/",
                location: "Online",
                organizer: "Major League Hacking",
                startDate: date(2026, 8, 7),
                endDate: date(2026, 8, 13),
                applicationDeadline: date(2026, 8, 13),
                format: .virtual,
                isFeatured: false,
                tags: [
                    virtualTag,
                    aiTag,
                    globalTag
                ]
            ),

            Hackathon(
                id: UUID(
                    uuidString:
                        "1b0b2e8f-8920-469e-978a-f34286dfcc56"
                ) ?? UUID(),
                name: "Build with Gemini XPRIZE",
                summary:
                    "A global virtual challenge hosted by XPRIZE with a $2,000,000 prize pool.",
                websiteURL:
                    "https://xprize.devpost.com/",
                location: "Online",
                organizer: "XPRIZE",
                startDate: date(2026, 5, 19),
                endDate: date(2026, 8, 17),
                applicationDeadline: date(2026, 8, 17),
                format: .virtual,
                isFeatured: true,
                tags: [
                    virtualTag,
                    aiTag,
                    globalTag,
                    featuredTag
                ]
            ),

            Hackathon(
                id: UUID(
                    uuidString:
                        "651caba5-0669-4d1d-843b-e7892d0d4207"
                ) ?? UUID(),
                name: "MHacks 2026",
                summary:
                    "A student hackathon hosted by the University of Michigan with applications open.",
                websiteURL:
                    "https://mhacks.org/",
                location: "Ann Arbor, MI",
                organizer: "University of Michigan",
                startDate: date(2026, 9, 12),
                endDate: date(2026, 9, 13),
                applicationDeadline: date(2026, 9, 12),
                format: .inPerson,
                isFeatured: false,
                tags: [
                    inPersonTag,
                    studentTag,
                    universityTag
                ]
            ),

            Hackathon(
                id: UUID(
                    uuidString:
                        "74830296-690a-4566-9022-00e552a0907f"
                ) ?? UUID(),
                name:
                    "CS Girlies Annual Hackathon — Technology for Wellness",
                summary:
                    "A virtual hackathon focused on building technology for wellness, with $5,000 in prizes.",
                websiteURL:
                    "https://cs-girlies-wellness-hackathon.devpost.com",
                location: "Online",
                organizer: "CS Girlies",
                startDate: date(2026, 8, 14),
                endDate: date(2026, 8, 16),
                applicationDeadline: date(2026, 8, 14),
                format: .virtual,
                isFeatured: false,
                tags: [
                    virtualTag,
                    healthcareTag
                ]
            ),

            Hackathon(
                id: UUID(
                    uuidString:
                        "b703a6ab-c107-4bab-808f-076e0ec65afa"
                ) ?? UUID(),
                name: "LA Hacks AI Hackathon 2026",
                summary:
                    "An in-person AI hackathon hosted by UCLA in Los Angeles.",
                websiteURL:
                    "https://ai.lahacks.com/",
                location: "Los Angeles, CA",
                organizer: "UCLA",
                startDate: date(2026, 10, 17),
                endDate: date(2026, 10, 18),
                applicationDeadline: date(2026, 8, 28),
                format: .inPerson,
                isFeatured: true,
                tags: [
                    inPersonTag,
                    aiTag,
                    studentTag,
                    universityTag,
                    featuredTag
                ]
            ),

            Hackathon(
                id: UUID(
                    uuidString:
                        "4dcf8a02-80eb-4943-a22c-5ee51e7660d1"
                ) ?? UUID(),
                name: "Hack Dearborn 2026",
                summary:
                    "An in-person university hackathon hosted by the University of Michigan–Dearborn.",
                websiteURL:
                    "https://hackdearborn.org/",
                location: "Dearborn, MI",
                organizer:
                    "University of Michigan Dearborn",
                startDate: date(2026, 10, 3),
                endDate: date(2026, 10, 4),
                applicationDeadline: nil,
                format: .inPerson,
                isFeatured: false,
                tags: [
                    inPersonTag,
                    studentTag,
                    universityTag
                ]
            ),

            Hackathon(
                id: UUID(
                    uuidString:
                        "206fb171-68a4-4c5d-b888-4c9b8545e669"
                ) ?? UUID(),
                name: "Hack the North 2026",
                summary:
                    "An in-person student hackathon hosted by the University of Waterloo.",
                websiteURL:
                    "https://hackthenorth.com",
                location: "Toronto, ON",
                organizer: "University of Waterloo",
                startDate: date(2026, 9, 18),
                endDate: date(2026, 9, 20),
                applicationDeadline: date(2026, 7, 27),
                format: .inPerson,
                isFeatured: true,
                tags: [
                    inPersonTag,
                    studentTag,
                    universityTag,
                    featuredTag
                ]
            )
        ]

        for hackathon in hackathons {
            context.insert(hackathon)
        }

        try context.save()
    }
}
