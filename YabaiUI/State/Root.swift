//
//  Root.swift
//  YabaiUI
//
//  Created by Kody Deda on 2/7/21.
//

import SwiftUI
import ComposableArchitecture

// -- how to register keystrokes for skhd?
// -- klajd { store data in ApplicationSupport folder }

//MARK:- Root

struct Root {
    struct State: Equatable {
        var yabai = Yabai.State()
        var skhd = SKHD.State()
        var errorString: String = ""
        
        let yabaiPath: URL = FileManager.default
            .urls(for: .documentDirectory, in: .userDomainMask)[0]
            .appendingPathComponent("Yabai.json")
        
        let skhdPath: URL = FileManager.default
            .urls(for: .documentDirectory, in: .userDomainMask)[0]
            .appendingPathComponent("SKHD.json")
        
        let yabaiConfigPath: URL = FileManager.default
            .urls(for: .documentDirectory, in: .userDomainMask)[0]
            .appendingPathComponent("YabaiConfig.json")
        
        let skhdConfigPath: URL = FileManager.default
            .urls(for: .documentDirectory, in: .userDomainMask)[0]
            .appendingPathComponent("SKHDConfig.json")
    }
    
    enum Action: Equatable {
        case yabai(Yabai.Action)
        case skhd(SKHD.Action)
        case saveData
        case loadData
        case exportData
    }
    
    struct Environment {
        // environment
        
        func save(state: State) -> Result<Bool, Error> {
            do {
                let encodedYabaiState = try JSONEncoder().encode(state.yabai)
                try encodedYabaiState.write(to: state.yabaiPath)
                
                let encodedSKHDState = try JSONEncoder().encode(state.skhd)
                try encodedSKHDState.write(to: state.skhdPath)

                return .success(true)
                
            } catch {
                return .failure(error)
            }
        }

        func load(state: State) -> Result<(Yabai.State, SKHD.State), Error> {
            do {
                let yabaiData = try Data(contentsOf: state.yabaiPath)
                let decodedYabaiState = try JSONDecoder().decode(Yabai.State.self, from: yabaiData)
                
                let skhdData = try Data(contentsOf: state.skhdPath)
                let decodedSKHDState = try JSONDecoder().decode(SKHD.State.self, from: skhdData)

                return .success((decodedYabaiState, decodedSKHDState))
            }
            catch {
                return .failure(error)
            }
        }
        
        func exportConfigs(state: State) -> Result<Bool, Error> {
            do {
                let yabaiConfigData = createYabaiConfig(state: state)
                try yabaiConfigData.write(to: state.yabaiConfigPath, atomically: true, encoding: .utf8)
                
                let skhdConfigData = createSKHDConfig(state: state)
                try skhdConfigData.write(to: state.skhdConfigPath, atomically: true, encoding: .utf8)
                return .success(true)
            } catch {
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
        Yabai.reducer.pullback(
            state: \.yabai,
            action: /Action.yabai,
            environment: { _ in .init() }
        ),
        SKHD.reducer.pullback(
            state: \.skhd,
            action: /Action.skhd,
            environment: { _ in .init() }
        ),
        Reducer { state, action, environment in
            switch action {
            
            case let .yabai(subAction):
                return Effect(value: .saveData)
                
            case let .skhd(subAction):
                return .none
                
            case .saveData:
                switch environment.save(state: state) {
                case .success:
                    state.errorString = ""
                case let .failure(error):
                    state.errorString = "Failed to save State"
                }
                return .none
                
            case .loadData:
                switch environment.load(state: state) {
                case let .success((decodedYabaiState, decodedSKHDState)):
                    state.yabai = decodedYabaiState
                    state.skhd = decodedSKHDState
                case let .failure(error):
                    state.errorString = "Failed to load State"
                }
                return .none
                
            case .exportData:
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


// MARK:- RootView

struct RootView: View {
    let store: Store<Root.State, Root.Action>
    
    var body: some View {
        WithViewStore(store) { viewStore in
            List {
                Section(header: Text("Yabai Settings")) {
                    YabaiView(store: store.scope(
                                state: \.yabai,
                                action: Root.Action.yabai))
                }
                Divider()
                Section(header: Text("SKHD Settings")) {
                    SKHDView(store: store.scope(
                                state: \.skhd,
                                action: Root.Action.skhd))
                }
            }
            .onAppear { viewStore.send(.loadData) }
            .toolbar {
                ToolbarItem {
                    Button("Export Data") {
                        viewStore.send(.exportData)
                    }
                }
            }
        }
    }
}

struct RootView_Previews: PreviewProvider {
    static var previews: some View {
        RootView(store: Root.defaultStore)
    }
}

