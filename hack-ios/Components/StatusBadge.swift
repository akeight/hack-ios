//
//  StatusBadge.swift
//  hack-ios
//
//  Created by Ally Keightley on 7/10/26.
//

import SwiftUI

struct StatusBadge: View {
    let status: ApplicationStatus

    var body: some View {
        Text(status.displayName)
            .font(.caption.weight(.semibold))
            .padding(.horizontal, 10)
            .padding(.vertical, 5)
            .background(backgroundStyle)
            .clipShape(Capsule())
    }

    private var backgroundStyle: some ShapeStyle {
        switch status {
        case .interested, .planning:
            return Color.blue.opacity(0.15)

        case .applied:
            return Color.orange.opacity(0.15)

        case .accepted, .attending, .attended:
            return Color.green.opacity(0.15)

        case .waitlisted:
            return Color.yellow.opacity(0.2)

        case .rejected, .withdrawn:
            return Color.red.opacity(0.15)
        }
    }
}
