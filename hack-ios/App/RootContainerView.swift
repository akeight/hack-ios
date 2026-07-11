//
//  RootContainerView.swift
//  hack-ios
//
//  Hosts the animated splash over the main app and applies the
//  user's appearance preference app-wide.
//

import SwiftUI

struct RootContainerView: View {
    @AppStorage(AppThemeStorage.key)
    private var appTheme: AppTheme = .system

    @State private var isShowingSplash = true

    var body: some View {
        RootTabView()
            .tint(.brandOrange)
            .overlay {
                if isShowingSplash {
                    SplashView {
                        withAnimation(.easeOut(duration: 0.2)) {
                            isShowingSplash = false
                        }
                    }
                    .transition(.opacity)
                }
            }
            .preferredColorScheme(appTheme.colorScheme)
    }
}

#Preview {
    RootContainerView()
}
