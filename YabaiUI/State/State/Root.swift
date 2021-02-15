//
//  Root.swift
//  YabaiUI
//
//  Created by Kody Deda on 2/7/21.
//

import SwiftUI
import ComposableArchitecture

struct Root {
    struct State: Equatable {
        var settings = Settings.State()
        var onboarding = Onboarding.State()
        var configManager = ConfigManager.State()
        var errorString: String = ""
        
        var settingsDataURL: URL {
            yabaiUIApplicationSupportDirectory
            .appendingPathComponent("settingsData.json")
        }
        var yabaiUIApplicationSupportDirectory: URL {
            let path = FileManager.default
                .urls(for: .applicationSupportDirectory, in: .userDomainMask)[0]
                .appendingPathComponent("YabaiUI")
            
            if !FileManager.default.fileExists(atPath: path.absoluteString) {
                try! FileManager.default
                    .createDirectory(at: path, withIntermediateDirectories: true, attributes: nil)
            }
            return path
        }
    }
    
    enum Action: Equatable {
        case settings(Settings.Action)
        case onboarding(Onboarding.Action)
        case configManager(ConfigManager.Action)
        case saveSettings
        case loadSettings
    }
    
    struct Environment {
        func saveSettings(state: State) -> Result<Bool, Error> {
            do {
                let encoded = try JSONEncoder().encode(state.settings)
                try encoded.write(to: state.settingsDataURL)
                return .success(true)
            } catch {
                return .failure(error)
            }
        }
        func loadSettings(state: State) -> Result<(Settings.State), Error> {
            do {
                let data = try Data(contentsOf: state.settingsDataURL)
                let decoded = try JSONDecoder().decode(Settings.State.self, from: data)
                return .success(decoded)
            }
            catch {
                return .failure(error)
            }
        }
    }
}

extension Root {
    static let reducer = Reducer<State, Action, Environment>.combine(
        Settings.reducer.pullback(
            state: \.settings,
            action: /Root.Action.settings,
            environment: { _ in .init() }
        ),
        Onboarding.reducer.pullback(
            state: \.onboarding,
            action: /Root.Action.onboarding,
            environment: { _ in () }
        ),
        ConfigManager.reducer.pullback(
            state: \.configManager,
            action: /Root.Action.configManager,
            environment: { _ in .init() }
        ),
        Reducer { state, action, environment in
            switch action {
                        
            case let .settings(subAction):
                return Effect(value: .saveSettings)

            case let .onboarding(subAction):
                return .none
                
            case let .configManager(subAction):
                return .none
                
            case .saveSettings:
                switch environment.saveSettings(state: state) {
                case .success:
                    state.errorString = ""
                case let .failure(error):
                    state.errorString = "Failed to save State"
                }
                return .none
                
            case .loadSettings:
                switch environment.loadSettings(state: state) {
                case let .success(decoded):
                    state.settings = decoded
                case let .failure(error):
                    state.errorString = "Failed to load State"
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
