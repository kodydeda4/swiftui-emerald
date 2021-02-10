//
//  SpaceSettings.swift
//  YabaiUI
//
//  Created by Kody Deda on 2/7/21.
//

import SwiftUI
import ComposableArchitecture

// -- how to register keystrokes for skhd?

//MARK:- Root

struct Root {
    struct State: Equatable {
        var yabai = Yabai.State()
        var skhd = SKHD.State()
        var errorString: String = ""
        
        //let yabaiFileURL = Bundle.main.url(forResource: "YabaiData", withExtension: "json")!

        let yabaiFileURL: URL = FileManager
            .default
            .urls(for: .documentDirectory, in: .userDomainMask)
            .first!
            .appendingPathComponent("Yabai")
            .appendingPathExtension("json")
        
        let skhdFileURL: URL = FileManager
            .default
            .urls(for: .documentDirectory, in: .userDomainMask)
            .first!
            .appendingPathComponent("SKHD")
            .appendingPathExtension("json")
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
//        func mySave(state: State)
        
        func save(state: State) -> Result<Bool, Error> {
            do {
                // save yabai
                let encoded1 = try JSONEncoder().encode(state.yabai)
                try encoded1.write(to: state.yabaiFileURL)
                
                // save skhd
                let encoded2 = try JSONEncoder().encode(state.skhd)
                try encoded2.write(to: state.skhdFileURL)
                return .success(true)
            } catch {
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
                    state.errorString = "Failed to save"
                }
                return .none
                
            case .loadData:
                // load yabai
                if let data = try? Data(contentsOf: state.yabaiFileURL) {
                    if let decodedState = try? JSONDecoder().decode(Yabai.State.self, from: data) {
                        state.yabai = decodedState
                    }
                }
                // load skhd
                if let data = try? Data(contentsOf: state.skhdFileURL) {
                    if let decodedState = try? JSONDecoder().decode(SKHD.State.self, from: data) {
                        state.skhd = decodedState
                    }
                }
                return .none
                
            case .exportData:
                // Export YabaiConfig
                let yabaiConfigData = "Yabai's Specialy Formatted Config File"
                
                let yabaiConfigPath: URL = FileManager
                    .default
                    .urls(for: .documentDirectory, in: .userDomainMask)
                    .first!
                    .appendingPathComponent("YabaiConfig")
                    .appendingPathExtension("json")
                
                do {
                    try yabaiConfigData.write(to: yabaiConfigPath, atomically: true, encoding: .utf8)
                } catch {
                    print(error.localizedDescription)
                }
                
                // Export SKHDConfig
                let skhdConfigData = "SKHD's Specialy Formatted Config File"
                
                let skhdConfigPath: URL = FileManager
                    .default
                    .urls(for: .documentDirectory, in: .userDomainMask)
                    .first!
                    .appendingPathComponent("SKHDConfig")
                    .appendingPathExtension("json")
                
                do {
                    try skhdConfigData.write(to: skhdConfigPath, atomically: true, encoding: .utf8)
                } catch {
                    print(error.localizedDescription)
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
                    Button("Save") {
                        viewStore.send(.saveData)
                    }
                }
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

