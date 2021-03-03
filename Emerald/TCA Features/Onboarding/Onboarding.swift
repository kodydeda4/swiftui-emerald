//
//  Onboarding.swift
//  Emerald
//
//  Created by Kody Deda on 2/11/21.
//

import SwiftUI
import ComposableArchitecture

struct OnboardingFeatures: Identifiable, Equatable {
    var id = UUID()
    let featureName: String
    let image: Image
    let featureDescription: String
}

struct Onboarding {
    struct State: Equatable {
        var isOnboaring = false
        
        let features: [OnboardingFeatures] = [
            OnboardingFeatures(
                featureName: "Window Shadows",
                image: Image(systemName: "sun.max.fill"),
                featureDescription: "Toggle shadows on/off"
            ),
            OnboardingFeatures(
                featureName: "Window Borders",
                image: Image(systemName: "paintbrush"),
                featureDescription: "Apply colored borders to any app"
            ),
            OnboardingFeatures(
                featureName: "Window Transparency",
                image: Image(systemName: "macwindow"),
                featureDescription: "Set active and inactive transparency"
            ),
            OnboardingFeatures(
                featureName: "Picture-in-Picture",
                image: Image(systemName: "play.circle"),
                featureDescription: "Enable pip for all windows"
            ),
            OnboardingFeatures(
                featureName: "Sticky-Windows",
                image: Image(systemName: "display.2"),
                featureDescription: "Create windows that appear in all spaces"
            ),
            OnboardingFeatures(
                featureName: "Float Ontop",
                image: Image(systemName: "square.3.stack.3d.top.fill"),
                featureDescription: "Set floating windows to always-on-top"
            ),
        ]
    }
    
    enum Action: Equatable {
        case toggleIsOnboaring
    }
}

extension Onboarding {
    static let reducer = Reducer<State, Action, Void> {
        state, action, _ in
        switch action {
        
        case .toggleIsOnboaring:
            state.isOnboaring.toggle()
            return .none
            
        }
    }
}

extension Onboarding {
    static let defaultStore = Store(
        initialState: .init(),
        reducer: reducer,
        environment: ()
    )
}
