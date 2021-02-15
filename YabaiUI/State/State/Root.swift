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
        var onboarding = Onboarding.State()
        
        // Features.  Currently they just have yabai related stuffs.
        var space = Space.State()
        var config = Config.State()
        var errorString: String = ""
        
        
        var yabaiVersion: String = run("/usr/local/bin/yabai", "-v").stdout
        var skhdVersion: String = run("/usr/local/bin/skhd", "-v").stdout
        var brewVersion: String = run("/usr/local/bin/brew", "-v").stdout
        
        var yabaiPath: URL {
            yabaiUIApplicationSupportDirectory
            .appendingPathComponent("yabaiState.json")
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
        case space(Space.Action)
        case config(Config.Action)
        case save
        case load
        case exportConfigs
    }
    
    struct Environment {
        func save(state: State) -> Result<Bool, Error> {
            do {
                let encodedYabaiState = try JSONEncoder().encode(state.space)
                try encodedYabaiState.write(to: state.yabaiPath)
                return .success(true)
            } catch {
                return .failure(error)
            }
        }

        func load(state: State) -> Result<(Space.State), Error> {
            do {
                let yabaiData = try Data(contentsOf: state.yabaiPath)
                let decodedYabaiState = try JSONDecoder().decode(Space.State.self, from: yabaiData)
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
        Space.reducer.pullback(
            state: \.space,
            action: /Action.space,
            environment: { _ in .init() }
        ),
        Onboarding.reducer.pullback(
            state: \.onboarding,
            action: /Root.Action.onboarding,
            environment: { _ in .init() }
        ),
        Config.reducer.pullback(
            state: \.config,
            action: /Root.Action.config,
            environment: { _ in .init() }
        ),
        Reducer { state, action, environment in
            switch action {
        
            case let .space(subAction):
                return Effect(value: .save)
                                
            case let .config(subAction):
                return .none
                
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
                    state.space = decodedYabaiState
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
