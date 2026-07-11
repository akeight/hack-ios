//
//  Untitled.swift
//  hack-ios
//
//  Created by Ally Keightley on 7/10/26.
//

import Foundation
import SwiftData

@Model
final class Hackathon {
    @Attribute(.unique)
    var id: UUID

    var name: String
    var summary: String
    var websiteURL: String
    var location: String
    var organizer: String

    var startDate: Date?
    var endDate: Date?
    var applicationDeadline: Date?

    var formatRawValue: String
    var imageURL: String?

    var isFeatured: Bool
    var isSaved: Bool

    var prize: String
    var listingState: String
    var isActive: Bool
    var isVisible: Bool
    var source: String

    @Relationship(inverse: \Tag.hackathons)
    var tags: [Tag] = []

    @Relationship(
        deleteRule: .cascade,
        inverse: \Application.hackathon
    )
    var application: Application?

    @Relationship(
        deleteRule: .cascade,
        inverse: \DeadlineReminder.hackathon
    )
    var reminders: [DeadlineReminder] = []

    init(
        id: UUID = UUID(),
        name: String,
        summary: String = "",
        websiteURL: String = "",
        location: String = "",
        organizer: String = "",
        startDate: Date? = nil,
        endDate: Date? = nil,
        applicationDeadline: Date? = nil,
        format: HackathonFormat = .inPerson,
        imageURL: String? = nil,
        isFeatured: Bool = false,
        isSaved: Bool = false,
        prize: String = "",
        listingState: String = "",
        isActive: Bool = true,
        isVisible: Bool = true,
        source: String = "",
        tags: [Tag] = [],
        application: Application? = nil,
        reminders: [DeadlineReminder] = []
    ) {
        self.id = id
        self.name = name
        self.summary = summary
        self.websiteURL = websiteURL
        self.location = location
        self.organizer = organizer
        self.startDate = startDate
        self.endDate = endDate
        self.applicationDeadline = applicationDeadline
        self.formatRawValue = format.rawValue
        self.imageURL = imageURL
        self.isFeatured = isFeatured
        self.isSaved = isSaved
        self.prize = prize
        self.listingState = listingState
        self.isActive = isActive
        self.isVisible = isVisible
        self.source = source
        self.tags = tags
        self.application = application
        self.reminders = reminders
    }

    var format: HackathonFormat {
        get {
            HackathonFormat(rawValue: formatRawValue) ?? .inPerson
        }
        set {
            formatRawValue = newValue.rawValue
        }
    }
}
