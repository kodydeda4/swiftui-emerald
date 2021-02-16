//
//  Settings.swift
//  YabaiUI
//
//  Created by Kody Deda on 2/15/21.
//

import ComposableArchitecture

struct SettingsManager {
    struct State: Codable, Equatable {
        var errorString: String = ""

        var yabaiSettings = YabaiSettings.State()
        
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
    
    enum Action: Equatable {
        case save
        case load
        case yabaiSettings(YabaiSettings.Action)
    }
    
    struct Environment {
        func save(_ state: SettingsManager.State, to url: URL) -> Result<Bool, Error> {
            do {
                let encoded = try JSONEncoder().encode(state)
                try encoded.write(to: url)
                return .success(true)
            } catch {
                return .failure(error)
            }
        }
        func load(_ state: SettingsManager.State, from url: URL) -> Result<(SettingsManager.State), Error> {
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
}

extension SettingsManager {
    static let reducer = Reducer<State, Action, Environment>.combine(
        YabaiSettings.reducer.pullback(
            state: \.yabaiSettings,
            action: /Action.yabaiSettings,
            environment: { _ in () }
        ),
        Reducer { state, action, environment in
            switch action {
            
            case .save:
                switch environment.save(state, to: state.yabaiSettingsURL) {
                case .success:
                    state.errorString = ""
                case let .failure(error):
                    state.errorString = "Error - Failed to save state"
                }
                return .none
                
            case .load:
                switch environment.load(state, from: state.yabaiSettingsURL) {
                case let .success(decoded):
                    state = decoded
                case let .failure(error):
                    state.errorString = "Error - Failed to load state"
                }
                return .none
                                
            case let .yabaiSettings(subAction):
                return Effect(value: .save)
                
            }
        }
    )
}

extension SettingsManager {
    static let defaultStore = Store(
        initialState: .init(),
        reducer: reducer,
        environment: .init()
    )
}
