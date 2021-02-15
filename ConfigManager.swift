//
//  ConfigManager.swift
//  YabaiUI
//
//  Created by Kody Deda on 2/15/21.
//

import SwiftUI
import ComposableArchitecture
import SwiftShell


struct ConfigManager {
    struct State: Equatable {
        var errorString: String = ""

        var yabaiVersion: String = run("/usr/local/bin/yabai", "-v").stdout
        var skhdVersion: String = run("/usr/local/bin/skhd", "-v").stdout
        var brewVersion: String = run("/usr/local/bin/brew", "-v").stdout
        

        let yabaiConfigPath = URL(fileURLWithPath: NSHomeDirectory())
            .appendingPathComponent("yabaiConfig")
        

    }
    
    enum Action: Equatable {
        // action
        case exportConfigs
    }
    
    struct Environment {
        // environment
        func createYabaiConfig(state: State) -> String {
            return "Yabai's Specialy Formatted Config File"
        }
        
        func createSKHDConfig(state: State) -> String {
            return "SKHD's Specialy Formatted Config File"
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
    }
}

extension ConfigManager {
    static let reducer = Reducer<State, Action, Environment>.combine(
        Reducer { state, action, environment in
            switch action {
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

extension ConfigManager {
    static let defaultStore = Store(
        initialState: .init(),
        reducer: reducer,
        environment: .init()
    )
}

// MARK:- ConfigManagerView

struct ConfigManagerView: View {
    let store: Store<ConfigManager.State, ConfigManager.Action>
    
    var body: some View {
        WithViewStore(store) { viewStore in
            
        }
    }
}

struct ConfigManagerView_Previews: PreviewProvider {
    static var previews: some View {
        ConfigManagerView(store: ConfigManager.defaultStore)
    }
}
