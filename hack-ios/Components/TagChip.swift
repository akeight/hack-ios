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
            .font(.caption)
            .padding(.horizontal, 9)
            .padding(.vertical, 5)
            .background(.thinMaterial)
            .clipShape(Capsule())
    }
}
