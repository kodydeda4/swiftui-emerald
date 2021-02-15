//
//  Root.swift
//  YabaiUI
//
//  Created by Kody Deda on 2/7/21.
//

import SwiftUI
import ComposableArchitecture
import SwiftShell

struct Root {
    struct State: Equatable {
        var errorString: String = ""
        var onboarding = Onboarding.State()
        var settings = Settings.State()
        
        var yabaiVersion: String = run("/usr/local/bin/yabai", "-v").stdout
        var skhdVersion: String = run("/usr/local/bin/skhd", "-v").stdout
        var brewVersion: String = run("/usr/local/bin/brew", "-v").stdout
        
        var settingsDataURL: URL {
            yabaiUIApplicationSupportDirectory
            .appendingPathComponent("settingsData.json")
        }

        let yabaiConfigPath = URL(fileURLWithPath: NSHomeDirectory())
            .appendingPathComponent("yabaiConfig")
        
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
        case onboarding(Onboarding.Action)
        case settings(Settings.Action)
        case save
        case load
        case exportConfigs
    }
    
    struct Environment {
        func save(state: State) -> Result<Bool, Error> {
            do {
                let encodedState = try JSONEncoder().encode(state.settings)
                try encodedState.write(to: state.settingsDataURL)
                return .success(true)
            } catch {
                return .failure(error)
            }
        }

        func load(state: State) -> Result<(Settings.State), Error> {
            do {
                let yabaiData = try Data(contentsOf: state.settingsDataURL)
                let decodedYabaiState = try JSONDecoder().decode(Settings.State.self, from: yabaiData)
                return .success(decodedYabaiState)
            }
            catch {
                return .failure(error)
            }
        }
        
        func exportConfigs(state: State) -> Result<Bool, Error> {
            do {
                let yabaiConfigData = createYabaiConfig(state: state)
                try yabaiConfigData.write(to: state.yabaiConfigPath, atomically: true, encoding: .utf8)
                return .success(true)
            }
            catch {
                return .failure(error)
            }
        }
        
        func createYabaiConfig(state: State) -> String {
            return "Yabai's Specialy Formatted Config File"
        }
        
        func createSKHDConfig(state: State) -> String {
            return "SKHD's Specialy Formatted Config File"
        }
    }
}

extension Root {
    static let reducer = Reducer<State, Action, Environment>.combine(
        Onboarding.reducer.pullback(
            state: \.onboarding,
            action: /Root.Action.onboarding,
            environment: { _ in .init() }
        ),
        Settings.reducer.pullback(
            state: \.settings,
            action: /Root.Action.settings,
            environment: { _ in .init() }
        ),
        Reducer { state, action, environment in
            switch action {
        
                
            case let .settings(subAction):
                return Effect(value: .save)

            

            case let .onboarding(subAction):
                return .none
                
            case .save:
                switch environment.save(state: state) {
                case .success:
                    state.errorString = ""
                case let .failure(error):
                    state.errorString = "Failed to save State"
                }
                return .none
                
            case .load:
                switch environment.load(state: state) {
                case let .success(decodedYabaiState):
                    state.settings = decodedYabaiState
                case let .failure(error):
                    state.errorString = "Failed to load State"
                }
                return .none
                
            case .exportConfigs:
                switch environment.exportConfigs(state: state) {
                case .success:
                    state.errorString = ""
                case let .failure(error):
                    state.errorString = "Failed to export config files."
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
