//
//  MouseSettingsView.swift
//  Emerald
//
//  Created by Kody Deda on 3/5/21.
//

import SwiftUI
import ComposableArchitecture

struct MouseSettingsView: View {
    let store: Store<Yabai.State, Yabai.Action>
    let keyPath = Yabai.Action.keyPath
    
    var body: some View {
        WithViewStore(store) { viewStore in
            SectionView("Mouse") {
                Section(header: Text("Mouse Follows Focus").bold()) {
                    Toggle("Enabled", isOn: viewStore.binding(keyPath: \.mouseFollowsFocus, send: keyPath))
                }
                Divider()
                Section(header: Text("Focus Follows Focus").bold()) {
                    VStack(alignment: .leading) {
                        HStack {
                            Button("Off (Normal)") {
                                viewStore.send(.updateFocusFollowsMouse(.off))
                            }
                            Button("Autofocus") {
                                viewStore.send(.updateFocusFollowsMouse(.autofocus))
                            }
                            Button("Autoraise") {
                                viewStore.send(.updateFocusFollowsMouse(.autoraise))
                            }
                        }
                    }
                }
                Divider()
                Section(header: Text("Mouse Modifier").bold()) {
                    HStack {
                        Button("cmd") {
                            viewStore.send(.updateMouseModifier(.cmd))
                        }
                        Button("alt") {
                            viewStore.send(.updateMouseModifier(.alt))
                        }
                        Button("shift") {
                            viewStore.send(.updateMouseModifier(.shift))
                        }
                        Button("ctrl") {
                            viewStore.send(.updateMouseModifier(.ctrl))
                        }
                        Button("fn") {
                            viewStore.send(.updateMouseModifier(.fn))
                        }
                    }
                }
                Section {
                    Divider()
                    Section(header: Text("Left Click + Mouse Modifier Action").bold()) {
                        HStack {
                            Button("Move") {
                                viewStore.send(.updateMouseAction1(.move))
                            }
                            Button("Resize") {
                                viewStore.send(.updateMouseAction1(.resize))
                            }
                        }
                    }
                    Divider()
                    Section(header: Text("Right Click + Mouse Modifier Action").bold()) {
                        HStack {
                            Button("Move") {
                                viewStore.send(.updateMouseAction2(.move))
                            }
                            Button("Resize") {
                                viewStore.send(.updateMouseAction2(.resize))
                            }
                        }
                    }
                    Divider()
                    Section(header: Text("Drop Action").bold()) {
                        HStack {
                            Button("Swap") {
                                viewStore.send(.updateMouseDropAction(.swap))
                            }
                            Button("Stack") {
                                viewStore.send(.updateMouseDropAction(.stack))
                            }
                        }
                    }
                }
            }
        }
    }
}

// MARK:- SwiftUI_Previews
struct MouseSettingsView_Previews: PreviewProvider {
    static var previews: some View {
        MouseSettingsView(store: Yabai.defaultStore)
    }
}
