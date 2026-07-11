//
//  TagChip.swift
//  hack-ios
//
//  Created by Ally Keightley on 7/10/26.
//

import SwiftUI

struct TagChip: View {
    let name: String

    var body: some View {
        Text(name)
            .font(.caption.weight(.medium))
            .foregroundStyle(Color.brandOrange)
            .padding(.horizontal, 10)
            .padding(.vertical, 5)
            .background(Color.brandOrangeSoft)
            .clipShape(Capsule())
            .overlay(
                Capsule()
                    .stroke(Color.brandOrange.opacity(0.25), lineWidth: 1)
            )
    }
}
