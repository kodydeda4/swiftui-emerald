//
//  Settings.swift
//  YabaiUI
//
//  Created by Kody Deda on 2/15/21.
//

import ComposableArchitecture

/*------------------------------------------------------------------------------------------
 YABAI ascii documentation:
 ------------------------------------------------------------------------------------------
 - Section  6.1     - configuring Yabai.
 - Sections 6.2-6.7 - configuring actions to Yabai.

 https://github.com/koekeishiya/yabai/blob/master/doc/yabai.asciidoc#config
 ------------------------------------------------------------------------------------------*/

struct Settings {
    struct State: Codable, Equatable {
        var errorString: String = ""

        var globalSettings = GlobalSettings.State()
        var spaceSettings = SpaceSettings.State()
        
        var settingsURL: URL {
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
        case save
        case load
        case globalSettings(GlobalSettings.Action)
        case spaceSettings(SpaceSettings.Action)
    }
    
    struct Environment {
        func save(_ state: Settings.State, to url: URL) -> Result<Bool, Error> {
            do {
                let encoded = try JSONEncoder().encode(state)
                try encoded.write(to: url)
                return .success(true)
            } catch {
                return .failure(error)
            }
        }
        func load(_ state: Settings.State, from url: URL) -> Result<(Settings.State), Error> {
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

extension Settings {
    static let reducer = Reducer<State, Action, Environment>.combine(
        GlobalSettings.reducer.pullback(
            state: \.globalSettings,
            action: /Settings.Action.globalSettings,
            environment: { _ in () }
        ),
        SpaceSettings.reducer.pullback(
            state: \.spaceSettings,
            action: /Action.spaceSettings,
            environment: { _ in () }
        ),
        Reducer { state, action, environment in
            switch action {
            
            case .save:
                switch environment.save(state, to: state.settingsURL) {
                case .success:
                    state.errorString = ""
                case let .failure(error):
                    state.errorString = "Error - Failed to save state"
                }
                return .none
                
            case .load:
                switch environment.load(state, from: state.settingsURL) {
                case let .success(decoded):
                    state = decoded
                case let .failure(error):
                    state.errorString = "Error - Failed to load state"
                }
                return .none
                
            case let .globalSettings(subAction):
                return Effect(value: .save)
                
            case let .spaceSettings(subAction):
                return Effect(value: .save)
                
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
