//
//  SplashView.swift
//  hack-ios
//
//  Animated zoom-in launch screen showing the HackHQ logo.
//

import SwiftUI

struct SplashView: View {
    /// Called once the intro animation has fully finished.
    let onComplete: () -> Void

    @Environment(\.colorScheme) private var colorScheme

    @State private var scale: CGFloat = 0.15
    @State private var opacity: Double = 0

    /// Matches the logo art's baked-in background so the zoom stays seamless:
    /// cream behind `LightLogo`, ink behind `DarkLogo`.
    private var backdrop: Color {
        colorScheme == .dark ? Color.brandBackground : Color.brandCream
    }

    var body: some View {
        ZStack {
            backdrop
                .ignoresSafeArea()

            Image("AppLogo")
                .resizable()
                .scaledToFit()
                .frame(maxWidth: 260)
                .scaleEffect(scale)
                .opacity(opacity)
        }
        .task {
            await runAnimation()
        }
    }

    private func runAnimation() async {
        withAnimation(
            .spring(response: 0.7, dampingFraction: 0.65)
        ) {
            scale = 1.0
            opacity = 1
        }

        try? await Task.sleep(for: .seconds(1.1))

        withAnimation(.easeIn(duration: 0.35)) {
            scale = 1.4
            opacity = 0
        }

        try? await Task.sleep(for: .seconds(0.35))

        onComplete()
    }
}

#Preview {
    SplashView(onComplete: {})
}
