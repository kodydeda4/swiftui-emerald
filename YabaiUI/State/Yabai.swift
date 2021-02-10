//
//  Yabai.swift
//  YabaiUI
//
//  Created by Kody Deda on 2/10/21.
//
//------------------------------------------------------------------------
// Yabai
// - A tiling window manager for macOS based on binary space partitioning
//   https://github.com/koekeishiya/yabai/blob/master/doc/yabai.asciidoc
//------------------------------------------------------------------------

//MARK:- Yabai

struct YabaiSpaceSettings: Equatable, Codable {
    enum Layout: String, Codable, CaseIterable, Identifiable {
        case bsp
        case stack
        case float
        
        var id: Layout { self }
    }
    
    var layout: Layout = .float
    var topPadding: Int = 0
    var bottomPadding: Int = 0
    var leftPadding: Int = 0
    var rightPadding: Int = 0
    var windowGap: Int = 0
}

import SwiftUI
import ComposableArchitecture

struct Yabai {
    struct State: Equatable, Codable {
        var yabaiSpaceSettings = YabaiSpaceSettings()
    }
    
    enum Action: Equatable {
        case updateLayout(YabaiSpaceSettings.Layout)
        case updateTopPadding(Int)
        case updateBottomPadding(Int)
        case updateLeftPadding(Int)
        case updateRightPadding(Int)
        case updateWindowGap(Int)
    }
    
    struct Environment {
        // environment
    }
}

extension Yabai {
    static let reducer = Reducer<State, Action, Environment>.combine(
        Reducer { state, action, environment in
            switch action {
            
            case let .updateLayout(layout):
                state.yabaiSpaceSettings.layout = layout
                return .none
                
            case let .updateTopPadding(int):
                state.yabaiSpaceSettings.topPadding = int
                return.none
                
            case let .updateBottomPadding(int):
                state.yabaiSpaceSettings.bottomPadding = int
                return.none
                
            case let .updateLeftPadding(int):
                state.yabaiSpaceSettings.leftPadding = int
                return.none
                
            case let .updateRightPadding(int):
                state.yabaiSpaceSettings.rightPadding = int
                return.none
                
            case let .updateWindowGap(int):
                state.yabaiSpaceSettings.windowGap = int
                return.none
            }
        }
    )
}

extension Yabai {
    static let defaultStore = Store(
        initialState: .init(),
        reducer: reducer,
        environment: .init()
    )
}

// MARK:- YabaiView

struct YabaiView: View {
    let store: Store<Yabai.State, Yabai.Action>
    
    var body: some View {
        WithViewStore(store) { viewStore in
            List {
                Section(header: Text("Space Settings")) {
                    Picker("Layout", selection:
                            viewStore.binding(
                                get: \.yabaiSpaceSettings.layout,
                                send: Yabai.Action.updateLayout)
                    ) {
                        ForEach(YabaiSpaceSettings.Layout.allCases) {
                            Text($0.rawValue)
                        }
                        
                    }
                    HStack {
                        Text("Top Padding")
                        TextField(
                            "",
                            value: viewStore.binding(
                                get: \.yabaiSpaceSettings.topPadding,
                                send: Yabai.Action.updateTopPadding),
                            formatter: NumberFormatter()
                        )
                    }
                    
                    HStack {
                        Text("Bottom Padding")
                        TextField(
                            "",
                            value: viewStore.binding(
                                get: \.yabaiSpaceSettings.bottomPadding,
                                send: Yabai.Action.updateBottomPadding
                            ),
                            formatter: NumberFormatter()
                        )
                    }
                    
                    HStack {
                        Text("Left Padding")
                        TextField(
                            "",
                            value: viewStore.binding(
                                get: \.yabaiSpaceSettings.leftPadding,
                                send: Yabai.Action.updateLeftPadding),
                            formatter: NumberFormatter()
                        )
                    }
                    
                    HStack {
                        Text("Right Padding")
                        TextField(
                            "",
                            value: viewStore.binding(
                                get: \.yabaiSpaceSettings.rightPadding,
                                send: Yabai.Action.updateRightPadding
                            ),
                            formatter: NumberFormatter()
                        )
                    }
                }
            }
            .padding()
        }
    }
}

struct YabaiView_Previews: PreviewProvider {
    static var previews: some View {
        YabaiView(store: Yabai.defaultStore)
    }
}
