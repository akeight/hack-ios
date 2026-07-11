//
//  Tag.swift
//  hack-ios
//
//  Created by Ally Keightley on 7/10/26.
//

import Foundation
import SwiftData

@Model
final class Tag {
    @Attribute(.unique)
    var id: UUID

    var name: String
    var hackathons: [Hackathon] = []

    init(
        id: UUID = UUID(),
        name: String,
        hackathons: [Hackathon] = []
    ) {
        self.id = id
        self.name = name
        self.hackathons = hackathons
    }
}
