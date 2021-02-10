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
        
        let yabaiURL: URL = FileManager.default
            .urls(for: .documentDirectory, in: .userDomainMask)[0]
            .appendingPathComponent("Yabai.json")
        
        let skhdURL: URL = FileManager.default
            .urls(for: .documentDirectory, in: .userDomainMask)[0]
            .appendingPathComponent("SKHD.json")
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
                try encodedYabaiState.write(to: state.yabaiURL)
                
                let encodedSKHDState = try JSONEncoder().encode(state.skhd)
                try encodedSKHDState.write(to: state.skhdURL)

                return .success(true)
                
            } catch {
                return .failure(error)
            }
        }

        func load(state: State) -> Result<(Yabai.State, SKHD.State), Error> {
            do {
                let yabaiData = try Data(contentsOf: state.yabaiURL)
                let decodedYabaiState = try JSONDecoder().decode(Yabai.State.self, from: yabaiData)
                
                let skhdData = try Data(contentsOf: state.skhdURL)
                let decodedSKHDState = try JSONDecoder().decode(SKHD.State.self, from: skhdData)

                return .success((decodedYabaiState, decodedSKHDState))
            }
            catch {
                return .failure(error)
            }
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
//                // Export YabaiConfig
//                let yabaiConfigData = "Yabai's Specialy Formatted Config File"
//
//                let yabaiConfigPath: URL = FileManager
//                    .default
//                    .urls(for: .documentDirectory, in: .userDomainMask)
//                    .first!
//                    .appendingPathComponent("YabaiConfig")
//                    .appendingPathExtension("json")
//
//                do {
//                    try yabaiConfigData.write(to: yabaiConfigPath, atomically: true, encoding: .utf8)
//                } catch {
//                    print(error.localizedDescription)
//                }
//
//                // Export SKHDConfig
//                let skhdConfigData = "SKHD's Specialy Formatted Config File"
//
//                let skhdConfigPath: URL = FileManager
//                    .default
//                    .urls(for: .documentDirectory, in: .userDomainMask)
//                    .first!
//                    .appendingPathComponent("SKHDConfig")
//                    .appendingPathExtension("json")
//
//                do {
//                    try skhdConfigData.write(to: skhdConfigPath, atomically: true, encoding: .utf8)
//                } catch {
//                    print(error.localizedDescription)
//                }
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

