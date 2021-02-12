//
//  Yabai.swift
//  YabaiUI
//
//  Created by Kody Deda on 2/10/21.
//

/*---------------------------------------------------------------------------
    Yabai
    - A tiling window manager for macOS based on binary space partitioning
      https://github.com/koekeishiya/yabai/blob/master/doc/yabai.asciidoc
 ---------------------------------------------------------------------------*/

//MARK:- Yabai

import SwiftUI
import ComposableArchitecture

struct Yabai {
    struct State: Equatable, Codable {
        var layout: Layout = .float
        var paddingTop: Int = 0
        var paddingBottom: Int = 0
        var paddingLeft: Int = 0
        var paddingRight: Int = 0
        var windowGap: Int = 0
        
        enum Layout: String, Codable, CaseIterable, Identifiable {
            case bsp
            case stack
            case float
            
            var id: Layout { self }
        }
    }
    
    enum Action: Equatable {
        case updateLayout(State.Layout)
        case updatePaddingTop(Int)
        case updatePaddingBottom(Int)
        case updatePaddingLeft(Int)
        case updatePaddingRight(Int)
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
                state.layout = layout
                return .none
                
            case let .updatePaddingTop(int):
                state.paddingTop = int
                return .none
                
            case let .updatePaddingBottom(int):
                state.paddingBottom = int
                return .none
                
            case let .updatePaddingLeft(int):
                state.paddingLeft = int
                return .none
                
            case let .updatePaddingRight(int):
                state.paddingRight = int
                return .none
                
            case let .updateWindowGap(int):
                state.windowGap = int
                return .none
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
    @State var errorMessage: String = ""
    
    var body: some View {
        WithViewStore(store) { viewStore in
            VStack {
                Text(errorMessage)
                Button("float") {
                    errorMessage = AppleScript.yabaiSetFloating.execute()
                }
                Button("bsp") {
                    errorMessage = AppleScript.yabaiSetBSP.execute()
                }
                
                Picker("Layout", selection:
                        viewStore.binding(
                            get: \.layout,
                            send: Yabai.Action.updateLayout)
                ) {
                    ForEach(Yabai.State.Layout.allCases) {
                        Text($0.rawValue)
                    }
                }
                HStack {
                    Text("Top Padding")
                    TextField(
                        "",
                        value: viewStore.binding(
                            get: \.paddingTop,
                            send: Yabai.Action.updatePaddingTop),
                        formatter: NumberFormatter()
                    )
                }
                HStack {
                    Text("Bottom Padding")
                    TextField(
                        "",
                        value: viewStore.binding(
                            get: \.paddingBottom,
                            send: Yabai.Action.updatePaddingBottom
                        ),
                        formatter: NumberFormatter()
                    )
                }
                HStack {
                    Text("Left Padding")
                    TextField(
                        "",
                        value: viewStore.binding(
                            get: \.paddingLeft,
                            send: Yabai.Action.updatePaddingLeft),
                        formatter: NumberFormatter()
                    )
                }
                HStack {
                    Text("Right Padding")
                    TextField(
                        "",
                        value: viewStore.binding(
                            get: \.paddingRight,
                            send: Yabai.Action.updatePaddingRight
                        ),
                        formatter: NumberFormatter()
                    )
                }
            }
        }
    }
}

struct YabaiView_Previews: PreviewProvider {
    static var previews: some View {
        YabaiView(store: Yabai.defaultStore)
    }
}
