//
//  Untitled.swift
//  hack-ios
//
//  Created by Ally Keightley on 7/10/26.
//

import Foundation
import SwiftData

@Model
final class Application {
    @Attribute(.unique)
    var id: UUID

    var statusRawValue: String
    var appliedAt: Date?
    var notes: String
    var updatedAt: Date

    var hackathon: Hackathon?

    init(
        id: UUID = UUID(),
        status: ApplicationStatus = .interested,
        appliedAt: Date? = nil,
        notes: String = "",
        updatedAt: Date = .now,
        hackathon: Hackathon? = nil
    ) {
        self.id = id
        self.statusRawValue = status.rawValue
        self.appliedAt = appliedAt
        self.notes = notes
        self.updatedAt = updatedAt
        self.hackathon = hackathon
    }

    var status: ApplicationStatus {
        get {
            ApplicationStatus(rawValue: statusRawValue) ?? .interested
        }
        set {
            statusRawValue = newValue.rawValue
            updatedAt = .now
        }
    }
}
