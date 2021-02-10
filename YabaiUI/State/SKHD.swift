//
//  Skhd.swift
//  YabaiUI
//
//  Created by Kody Deda on 2/10/21.
//
//------------------------------------------------------------------------
// SKHD
// - Simple hotkey daemon for macOS
//   https://github.com/koekeishiya/skhd
//------------------------------------------------------------------------

//MARK:- SKHD

import SwiftUI
import ComposableArchitecture


struct SKHD {
    struct State: Equatable, Codable {
        var skhdString: String = ""

    }
    
    enum Action: Equatable {
        case updateSKHDString(String)
        
    }
    
    struct Environment {
        // environment
    }
}

extension SKHD {
    static let reducer = Reducer<State, Action, Environment>.combine(
        Reducer { state, action, environment in
            switch action {
            
            case let .updateSKHDString(string):
                state.skhdString = string
                return .none
            
            }
        }
    )
}

extension SKHD {
    static let defaultStore = Store(
        initialState: .init(),
        reducer: reducer,
        environment: .init()
    )
}

// MARK:- SKHDView

struct SKHDView: View {
    let store: Store<SKHD.State, SKHD.Action>
    
    var body: some View {
        WithViewStore(store) { viewStore in
            List {
                Text("SKHD String")
                    .foregroundColor(.gray)
                
                TextField("Untitled", text: viewStore.binding(
                    get: \.skhdString,
                    send: SKHD.Action.updateSKHDString
                ))
            }
        }
    }
}

struct SKHDView_Previews: PreviewProvider {
    static var previews: some View {
        SKHDView(store: SKHD.defaultStore)
    }
}
