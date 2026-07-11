//
//  BrandButtonStyle.swift
//  hack-ios
//
//  Reusable HackHQ button styles.
//

import SwiftUI

/// Filled brand-orange button for primary actions.
struct PrimaryBrandButtonStyle: ButtonStyle {
    var isEnabledOverride: Bool = true

    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(.brandHeadline)
            .foregroundStyle(.white)
            .padding(.vertical, 14)
            .frame(maxWidth: .infinity)
            .background(Color.brandOrange)
            .clipShape(
                RoundedRectangle(
                    cornerRadius: BrandMetrics.controlCornerRadius,
                    style: .continuous
                )
            )
            .opacity(configuration.isPressed ? 0.85 : 1)
            .scaleEffect(configuration.isPressed ? 0.98 : 1)
            .animation(
                .easeOut(duration: 0.15),
                value: configuration.isPressed
            )
    }
}

/// Outlined button for secondary actions.
struct SecondaryBrandButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(.brandHeadline)
            .foregroundStyle(Color.brandInk)
            .padding(.vertical, 14)
            .frame(maxWidth: .infinity)
            .background(Color.brandSurface)
            .clipShape(
                RoundedRectangle(
                    cornerRadius: BrandMetrics.controlCornerRadius,
                    style: .continuous
                )
            )
            .overlay(
                RoundedRectangle(
                    cornerRadius: BrandMetrics.controlCornerRadius,
                    style: .continuous
                )
                .stroke(Color.brandOrange.opacity(0.5), lineWidth: 1.5)
            )
            .opacity(configuration.isPressed ? 0.85 : 1)
            .scaleEffect(configuration.isPressed ? 0.98 : 1)
            .animation(
                .easeOut(duration: 0.15),
                value: configuration.isPressed
            )
    }
}

extension ButtonStyle where Self == PrimaryBrandButtonStyle {
    static var primaryBrand: PrimaryBrandButtonStyle {
        PrimaryBrandButtonStyle()
    }
}

extension ButtonStyle where Self == SecondaryBrandButtonStyle {
    static var secondaryBrand: SecondaryBrandButtonStyle {
        SecondaryBrandButtonStyle()
    }
}
