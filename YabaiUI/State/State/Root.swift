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
        var exportErrorString: String = ""
        
        var yabaiSettings = YabaiSettings.State()
        var onboarding = Onboarding.State()
        
        var yabaiVersion: String = run("/usr/local/bin/yabai", "-v").stdout
        var skhdVersion: String = run("/usr/local/bin/skhd", "-v").stdout
        var brewVersion: String = run("/usr/local/bin/brew", "-v").stdout
        
        var yabaiSettingsURL: URL {
            yabaiUIApplicationSupportDirectory
                .appendingPathComponent("yabaiSettings.json")
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
    
    struct Environment {
        func exportYabaiConfig(_ yabaiSettingsState: YabaiSettings.State) -> Result<Bool, Error> {
            do {
                let path = URL(fileURLWithPath: NSHomeDirectory())
                    .appendingPathComponent("yabaiConfig")
                
                let data: String = yabaiSettingsState.asConfig
                
                try data.write(to: path, atomically: true, encoding: .utf8)
                
                return .success(true)
            }
            catch {
                return .failure(error)
            }
        }
        
        func saveYabaiSettings(_ state: YabaiSettings.State, to url: URL) -> Result<Bool, Error> {
            do {
                let encoded = try JSONEncoder().encode(state)
                try encoded.write(to: url)
                return .success(true)
            } catch {
                return .failure(error)
            }
        }
        func loadYabaiSettings(_ state: YabaiSettings.State, from url: URL) -> Result<(YabaiSettings.State), Error> {
            do {
                let data = try Data(contentsOf: url)
                let decoded = try JSONDecoder().decode(type(of: state), from: data)
                return .success(decoded)
            }
            catch {
                return .failure(error)
            }
        }
    }
    
    enum Action: Equatable {
        case yabaiSettings(YabaiSettings.Action)
        case onboarding(Onboarding.Action)
        case saveYabaiSettings
        case loadYabaiSettings
        case exportYabaiConfig
    }
}

extension Root {
    static let reducer = Reducer<State, Action, Environment>.combine(
        YabaiSettings.reducer.pullback(
            state: \.yabaiSettings,
            action: /Root.Action.yabaiSettings,
            environment: { _ in () }
        ),
        
        Onboarding.reducer.pullback(
            state: \.onboarding,
            action: /Root.Action.onboarding,
            environment: { _ in () }
        ),
        Reducer { state, action, environment in
            switch action {
            
            case .saveYabaiSettings:
                switch environment.saveYabaiSettings(state.yabaiSettings, to: state.yabaiSettingsURL) {
                case .success:
                    state.errorString = ""
                case let .failure(error):
                    state.errorString = "Error - Failed to save state"
                }
                return .none
                
            case .loadYabaiSettings:
                switch environment.loadYabaiSettings(state.yabaiSettings, from: state.yabaiSettingsURL) {
                case let .success(decoded):
                    state.yabaiSettings = decoded
                case let .failure(error):
                    state.errorString = "Error - Failed to load state"
                }
                return .none
                
            case let .yabaiSettings(subAction):
                return Effect(value: .saveYabaiSettings)
                
            case .exportYabaiConfig:
                switch environment.exportYabaiConfig(state.yabaiSettings) {
                case .success:
                    state.exportErrorString = ""
                case let .failure(error):
                    state.errorString = "Failed to export config files."
                }
                return .none
                
            case .onboarding(_):
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

