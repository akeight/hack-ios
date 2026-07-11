//
//  Theme.swift
//  hack-ios
//
//  Central design-system tokens and reusable view styling for HackHQ.
//

import SwiftUI

// MARK: - Metrics

enum BrandMetrics {
    static let cardCornerRadius: CGFloat = 22
    static let controlCornerRadius: CGFloat = 14
    static let chipCornerRadius: CGFloat = 10

    static let cardPadding: CGFloat = 16
    static let screenPadding: CGFloat = 16
    static let sectionSpacing: CGFloat = 16
    static let stackSpacing: CGFloat = 12
}

// MARK: - Typography

extension Font {
    /// Heavy, condensed-feeling display font for hero titles.
    static let brandLargeTitle = Font.system(
        .largeTitle,
        design: .default
    ).weight(.heavy)

    static let brandTitle = Font.system(
        .title2,
        design: .default
    ).weight(.bold)

    static let brandHeadline = Font.system(
        .headline,
        design: .default
    ).weight(.semibold)

    static let brandSubheadline = Font.system(
        .subheadline,
        design: .default
    ).weight(.medium)

    /// Uppercased, tracked label used for section eyebrows.
    static let brandEyebrow = Font.system(
        .caption,
        design: .default
    ).weight(.bold)
}

// MARK: - Card styling

struct BrandCard: ViewModifier {
    var featured: Bool = false

    private var fill: Color {
        featured ? Color.brandCream : Color.brandSurface
    }

    private var strokeColor: Color {
        featured ? Color.brandOrange.opacity(0.45) : Color.brandHairline
    }

    private var strokeWidth: CGFloat {
        featured ? 1.5 : 1
    }

    func body(content: Content) -> some View {
        content
            .padding(BrandMetrics.cardPadding)
            .background(fill)
            .clipShape(
                RoundedRectangle(
                    cornerRadius: BrandMetrics.cardCornerRadius,
                    style: .continuous
                )
            )
            .overlay(
                RoundedRectangle(
                    cornerRadius: BrandMetrics.cardCornerRadius,
                    style: .continuous
                )
                .stroke(strokeColor, lineWidth: strokeWidth)
            )
            .shadow(
                color: Color.brandInk.opacity(0.06),
                radius: 12,
                x: 0,
                y: 6
            )
    }
}

extension View {
    /// Applies the standard HackHQ elevated card treatment.
    /// Set `featured` to use the warm cream accent surface with an orange edge.
    func brandCard(featured: Bool = false) -> some View {
        modifier(BrandCard(featured: featured))
    }

    /// Applies the brand background color, ignoring safe areas.
    func brandBackground() -> some View {
        background(
            Color.brandBackground.ignoresSafeArea()
        )
    }
}

// MARK: - Section eyebrow

/// A small uppercased, orange, tracked label used above section content.
struct SectionEyebrow: View {
    let text: String

    init(_ text: String) {
        self.text = text
    }

    var body: some View {
        Text(text.uppercased())
            .font(.brandEyebrow)
            .tracking(1.5)
            .foregroundStyle(Color.brandOrange)
    }
}
