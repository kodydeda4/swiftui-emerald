//
//  Settings.swift
//  YabaiUI
//
//  Created by Kody Deda on 2/15/21.
//

import ComposableArchitecture

struct Settings {
    struct State: Codable, Equatable {
        var errorString: String = ""

        var config = Config.State()
        var space = Space.State()
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
        case config(Config.Action)
        case space(Space.Action)
        case save
        case load
    }
    
    struct Environment {
        func save(state: State) -> Result<Bool, Error> {
            do {
                let encoded = try JSONEncoder().encode(state)
                try encoded.write(to: state.settingsDataURL)
                return .success(true)
            } catch {
                return .failure(error)
            }
        }
        func load(state: State) -> Result<(Settings.State), Error> {
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

extension Settings {
    static let reducer = Reducer<State, Action, Environment>.combine(
        Config.reducer.pullback(
            state: \.config,
            action: /Settings.Action.config,
            environment: { _ in () }
        ),
        Space.reducer.pullback(
            state: \.space,
            action: /Action.space,
            environment: { _ in () }
        ),
        Reducer { state, action, environment in
            switch action {                
            case let .config(subAction):
                return Effect(value: .save)
                
            case let .space(subAction):
                return Effect(value: .save)
                
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
                case let .success(decoded):
                    state = decoded
                case let .failure(error):
                    state.errorString = "Failed to load State"
                }
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
