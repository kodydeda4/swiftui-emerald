//
//  Root.swift
//  Emerald
//
//  Created by Kody Deda on 2/7/21.
//

import ComposableArchitecture

struct Root {
    struct State: Equatable {
        var yabai = Yabai.State()
        var skhd = SKHD.State()
        var animations = Animations.State()
        var onboarding  = Onboarding.State()
    }
    enum Action: Equatable {
        case yabai(Yabai.Action)
        case skhd(SKHD.Action)
        case animations(Animations.Action)
        case onboarding(Onboarding.Action)
    }
}

extension Root {
    static let reducer = Reducer<State, Action, Void>.combine(
        Yabai.reducer.pullback(
            state: \.yabai,
            action: /Root.Action.yabai,
            environment: { _ in .init() }
        ),
        SKHD.reducer.pullback(
            state: \.skhd,
            action: /Root.Action.skhd,
            environment: { _ in .init() }
        ),
        Animations.reducer.pullback(
            state: \.animations,
            action: /Root.Action.animations,
            environment: { _ in .init() }
        ),
        Onboarding.reducer.pullback(
            state: \.onboarding,
            action: /Root.Action.onboarding,
            environment: { _ in () }
        )
    )
}

extension Root {
    static let defaultStore = Store(
        initialState: .init(),
        reducer: reducer,
        environment: ()
    )
}
