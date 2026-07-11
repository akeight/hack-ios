//
//  HackathonFormat.swift
//  hack-ios
//
//  Created by Ally Keightley on 7/10/26.
//

import Foundation

enum HackathonFormat: String, Codable, CaseIterable, Identifiable {
    case inPerson
    case virtual
    case hybrid

    var id: String {
        rawValue
    }

    var displayName: String {
        switch self {
        case .inPerson:
            return "In Person"
        case .virtual:
            return "Virtual"
        case .hybrid:
            return "Hybrid"
        }
    }
}
