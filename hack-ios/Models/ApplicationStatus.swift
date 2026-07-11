//
//  ApplicationStatus.swift
//  hack-ios
//
//  Created by Ally Keightley on 7/10/26.
//

import Foundation

enum ApplicationStatus: String, Codable, CaseIterable, Identifiable {
    case interested
    case planning
    case applied
    case accepted
    case waitlisted
    case rejected
    case attending
    case attended
    case withdrawn

    var id: String {
        rawValue
    }

    var displayName: String {
        switch self {
        case .interested:
            return "Interested"
        case .planning:
            return "Planning to Apply"
        case .applied:
            return "Applied"
        case .accepted:
            return "Accepted"
        case .waitlisted:
            return "Waitlisted"
        case .rejected:
            return "Rejected"
        case .attending:
            return "Attending"
        case .attended:
            return "Attended"
        case .withdrawn:
            return "Withdrawn"
        }
    }
}
