//
//  SpaceSettings.swift
//  YabaiUI
//
//  Created by Kody Deda on 2/7/21.
//

import SwiftUI
import ComposableArchitecture

//MARK:- Root

struct Root {
    struct State: Equatable, Codable {
        var firstName: String = ""
        var lastName: String = ""
        
        let fileURL: URL = FileManager
            .default
            .urls(for: .documentDirectory, in: .userDomainMask)
            .first!
            .appendingPathComponent("YabaiUI")
            .appendingPathExtension("json")
        
    }
    
    enum Action: Equatable {
        case updateFirstName(String)
        case updateLastName(String)
        case saveData
        case loadData
    }
    
    struct Environment {
        // environment
    }
}

extension Root {
    static let reducer = Reducer<State, Action, Environment>.combine(
        
        Reducer { state, action, environment in
            switch action {
            
            case let .updateFirstName(string):
                state.firstName = string
                return .none
            
            case let .updateLastName(string):
                state.lastName = string
                return .none

            case .saveData:
                if let encoded = try? JSONEncoder().encode(state) {
                    try? encoded.write(to: state.fileURL)
                }
                return .none
                
            case .loadData:
                if let data = try? Data(contentsOf: state.fileURL) {
                    if let decodedState = try? JSONDecoder().decode(State.self, from: data) {
                        state = decodedState
                    }
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
                
                HStack {
                    Text("First Name")
                        .foregroundColor(.gray)
                    TextField("Untitled", text: viewStore.binding(
                        get: \.firstName,
                        send: Root.Action.updateFirstName
                    ))
                }
                
                HStack {
                    Text("Last Name")
                        .foregroundColor(.gray)
                    TextField("Untitled", text: viewStore.binding(
                        get: \.lastName,
                        send: Root.Action.updateLastName
                    ))
                }
            }
            .onAppear { viewStore.send(.loadData) }
            .toolbar {
                ToolbarItem {
                    Button("Save") {
                        viewStore.send(.saveData)
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

