//
//  Root.swift
//  YabaiUI
//
//  Created by Kody Deda on 2/7/21.
//

import SwiftUI
import ComposableArchitecture
import SwiftShell

//MARK:- Root

struct Root {
    struct State: Equatable {
        var yabai = Yabai.State()
        var skhd = SKHD.State()
        var onboarding = Onboarding.State()
        
        var yabaiVersion: String = run("/usr/local/bin/yabai", "-v").stdout
        var skhdVersion: String = run("/usr/local/bin/skhd", "-v").stdout
        var brewVersion: String = run("/usr/local/bin/brew", "-v").stdout
        
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

        var yabaiPath: URL {
            yabaiUIApplicationSupportDirectory
            .appendingPathComponent("yabaiState.json")
        }
        
        var skhdPath: URL {
            yabaiUIApplicationSupportDirectory
            .appendingPathComponent("skhdState.json")
        }
            
        let yabaiConfigPath = URL(fileURLWithPath: NSHomeDirectory())
            .appendingPathComponent("yabaiConfig")
        
        let skhdConfigPath = URL(fileURLWithPath: NSHomeDirectory())
            .appendingPathComponent("skhdConfig")

        var errorString: String = ""
        
    }
    
    enum Action: Equatable {
        case yabai(Yabai.Action)
        case skhd(SKHD.Action)
        case save
        case load
        case exportConfigs
        case onboarding(Onboarding.Action)
    }
    
    struct Environment {
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
        Onboarding.reducer.pullback(
            state: \.onboarding,
            action: /Root.Action.onboarding,
            environment: { _ in .init() }
        ),
        Reducer { state, action, environment in
            switch action {
        
            case let .yabai(subAction):
                return Effect(value: .save)
                
            case let .skhd(subAction):
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
                case let .success((decodedYabaiState, decodedSKHDState)):
                    state.yabai = decodedYabaiState
                    state.skhd = decodedSKHDState
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
                
            case let .onboarding(subAction):
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
                VStack(alignment: .leading) {
                    
                    Text("Yabai Version")
                    Text(viewStore.yabaiVersion).foregroundColor(.gray)
                        .padding(.bottom)
                    
                    Text("SKHD Version")
                    Text(viewStore.skhdVersion).foregroundColor(.gray)
                        .padding(.bottom)
                    
                    Text("HomeBrew Version")
                    Text(viewStore.brewVersion).foregroundColor(.gray)
                        .padding(.bottom)
                }
                
                
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
            .onAppear { viewStore.send(.load) }
            .toolbar {
                ToolbarItem {
                    Button("Export Data") {
                        viewStore.send(.exportConfigs)
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
