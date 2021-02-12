//
//  SKHD.swift
//  YabaiUI
//
//  Created by Kody Deda on 2/10/21.
//

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
