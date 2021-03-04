//
//  Root.swift
//  Emerald
//
//  Created by Kody Deda on 2/7/21.
//

import ComposableArchitecture

struct Root {
    struct State: Equatable {
        var yabai       = Yabai.State()
        var skhd        = SKHD.State()
        //var animations  = Animations.State()
        var animationSettings = AnimationSettings.State()
        var error: DataManagerError = .none
    
        var onboarding  = Onboarding.State()
    }
    enum Action: Equatable {
        case yabai(Yabai.Action)
        case skhd(SKHD.Action)
        case animationSettings(AnimationSettings.Action)
        case onboarding(Onboarding.Action)
        case saveState
        case loadState
        case exportConfig
        
    }
    
    struct Environment {
        let homeURL = URL(fileURLWithPath: NSHomeDirectory())
        
        func encodeState<State>(_ state: State, stateURL: URL) -> Result<Bool, DataManagerError> where State : Encodable {
            do {
                try JSONEncoder()
                    .encode(state)
                    .write(to: stateURL)
                return .success(true)
            } catch {
                return .failure(.encodeState)
            }
        }
        func decodeState<State>(_ state: State, stateURL: URL) -> Result<State, DataManagerError> where State : Decodable {
            do {
                let decoded = try JSONDecoder()
                    .decode(type(of: state), from: Data(contentsOf: stateURL))
                return .success(decoded)
            }
            catch {
                return .failure(.decodeState)
            }
        }
        func exportConfig(_ data: String, configURL: URL) -> Result<Bool, DataManagerError> {
            do {
                let data: String = data
                try data.write(to: configURL, atomically: true, encoding: .utf8)
                
                return .success(true)
            }
            catch {
                return .failure(.exportConfig)
            }
        }
    }
}

extension Root {
    static let reducer = Reducer<State, Action, Environment>.combine(
        Yabai.reducer.pullback(
            state: \.yabai,
            action: /Action.yabai,
            environment: { _ in () }
        ),
        SKHD.reducer.pullback(
            state: \.skhd,
            action: /Action.skhd,
            environment: { _ in () }
        ),
        AnimationSettings.reducer.pullback(
            state: \.animationSettings,
            action: /Action.animationSettings,
            environment: { _ in () }
        ),
        Onboarding.reducer.pullback(
            state: \.onboarding,
            action: /Action.onboarding,
            environment: { _ in () }
        ),
        Reducer { state, action, environment in
            switch action {
            case .yabai(_):
                return .none
                //return Effect(value: .saveState)
            case .skhd(_):
                return .none
                //return Effect(value: .saveState)
            case .onboarding(_):
                return .none
                //return Effect(value: .saveState)

            case let .animationSettings(subAction):
                return Effect(value: .saveState)
                
            case .saveState:
                switch environment.encodeState(state.animationSettings, stateURL: environment.homeURL.appendingPathComponent("temp")) {
                case .success:
                    state.error = .none
                case let .failure(error):
                    state.error = .encodeState
                }
                return .none
                
            case .loadState:
                switch environment.decodeState(state.animationSettings, stateURL: environment.homeURL.appendingPathComponent("temp")) {
                case let .success(decoded):
                    state.animationSettings = decoded
                case let .failure(error):
                    state.error = .decodeState
                }
                return .none
                
            case .exportConfig:
                switch environment.exportConfig(state.animationSettings.asConfig, configURL: environment.homeURL.appendingPathComponent("tempConfig")) {
                case .success:
                    state.error = .none
                case let .failure(error):
                    state.error = .exportConfig
                }
                return .none
                
            }
            
        }
    )
}

extension Root {
    static let defaultStore = Store(
        initialState: .init(),
        reducer: reducer,
        environment: .init()
    )
}
