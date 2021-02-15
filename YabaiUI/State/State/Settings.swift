//
//  Settings.swift
//  YabaiUI
//
//  Created by Kody Deda on 2/15/21.
//

import SwiftUI
import ComposableArchitecture

struct Settings {
    struct State: Codable, Equatable {
        var config = Config.State()
        var space = Space.State()
    }
    
    enum Action: Equatable {
        // action
        case config(Config.Action)
        case space(Space.Action)
    }
    
    struct Environment {
        // environment
    }
}

extension Settings {
    static let reducer = Reducer<State, Action, Environment>.combine(
        Config.reducer.pullback(
            state: \.config,
            action: /Settings.Action.config,
            environment: { _ in .init() }
        ),
        Space.reducer.pullback(
            state: \.space,
            action: /Action.space,
            environment: { _ in .init() }
        ),
        Reducer { state, action, environment in
            switch action {                
            case let .config(subAction):
                return .none
            case let .space(subAction):
                return .none

            }
        }
    )
}

extension Settings {
    static let defaultStore = Store(
        initialState: .init(),
        reducer: reducer,
        environment: .init()
    )
}

// MARK:- SettingsView

struct SettingsView: View {
    let store: Store<Settings.State, Settings.Action>
    
    var body: some View {
        WithViewStore(store) { viewStore in
            
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView(store: Settings.defaultStore)
    }
}
