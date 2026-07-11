//
//  DeadlineReminder.swift
//  hack-ios
//
//  Created by Ally Keightley on 7/10/26.
//

import Foundation
import SwiftData

@Model
final class DeadlineReminder {
    @Attribute(.unique)
    var id: UUID

    var reminderDate: Date
    var typeRawValue: String
    var customTitle: String?
    var isEnabled: Bool
    var notificationIdentifier: String?

    var hackathon: Hackathon?

    init(
        id: UUID = UUID(),
        reminderDate: Date,
        type: ReminderType,
        customTitle: String? = nil,
        isEnabled: Bool = true,
        notificationIdentifier: String? = nil,
        hackathon: Hackathon? = nil
    ) {
        self.id = id
        self.reminderDate = reminderDate
        self.typeRawValue = type.rawValue
        self.customTitle = customTitle
        self.isEnabled = isEnabled
        self.notificationIdentifier = notificationIdentifier
        self.hackathon = hackathon
    }

    var type: ReminderType {
        get {
            ReminderType(rawValue: typeRawValue) ?? .custom
        }
        set {
            typeRawValue = newValue.rawValue
        }
    }
}
