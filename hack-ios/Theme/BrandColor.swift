//
//  BrandColor.swift
//  hack-ios
//
//  HackHQ brand color tokens sourced from the brand board.
//

import SwiftUI

extension Color {
    /// Primary brand accent, `#ED5B29`.
    static let brandOrange = Color("BrandOrange")

    /// App background. Cream in light mode, near-black ink in dark mode.
    static let brandBackground = Color("BrandBackground")

    /// Primary text / ink. Near-black in light mode, cream in dark mode.
    static let brandInk = Color("BrandInk")

    /// Elevated surface for cards and grouped content.
    static let brandSurface = Color("BrandSurface")

    /// Warm cream accent surface. Cream in light mode, warm charcoal in dark mode.
    static let brandCream = Color("BrandCream")

    /// Subtle hairline / divider tuned for both appearances.
    static var brandHairline: Color {
        Color.brandInk.opacity(0.12)
    }

    /// Muted secondary ink for supporting copy.
    static var brandInkSecondary: Color {
        Color.brandInk.opacity(0.6)
    }

    /// Soft translucent orange for tinted backgrounds (chips, highlights).
    static var brandOrangeSoft: Color {
        Color.brandOrange.opacity(0.15)
    }
}
