//
//  ReminderType.swift
//  hack-ios
//
//  Created by Ally Keightley on 7/10/26.
//

import Foundation

enum ReminderType: String, Codable, CaseIterable, Identifiable {
    case applicationDeadline
    case registrationDeadline
    case travelBooking
    case eventStart
    case custom

    var id: String {
        rawValue
    }

    var displayName: String {
        switch self {
        case .applicationDeadline:
            return "Application Deadline"
        case .registrationDeadline:
            return "Registration Deadline"
        case .travelBooking:
            return "Travel Booking"
        case .eventStart:
            return "Event Start"
        case .custom:
            return "Custom"
        }
    }
}
