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
    let k = Yabai.Action.keyPath
    
    var body: some View {
        WithViewStore(store) { vs in
            SectionView("Mouse") {
                Section(header: Text("Mouse Follows Focus").bold()) {
                    Toggle("Enabled", isOn: vs.binding(keyPath: \.mouseFollowsFocus, send: k))
                }
                Divider()
                Section(header: Text("Focus Follows Focus").bold()) {
                    VStack(alignment: .leading) {
                        HStack {
                            Button("Off (Normal)") {
                                vs.send(.updateFocusFollowsMouse(.off))
                            }
                            Button("Autofocus") {
                                vs.send(.updateFocusFollowsMouse(.autofocus))
                            }
                            Button("Autoraise") {
                                vs.send(.updateFocusFollowsMouse(.autoraise))
                            }
                        }
                    }
                }
                Divider()
                Section(header: Text("Mouse Modifier").bold()) {
                    HStack {
                        Button("fn") {
                            vs.send(.updateMouseModifier(.fn))
                        }
                        Button("shift ⇧") {
                            vs.send(.updateMouseModifier(.shift))
                        }
                        Button("control ⌃") {
                            vs.send(.updateMouseModifier(.ctrl))
                        }
                        Button("option ⌥") {
                            vs.send(.updateMouseModifier(.alt))
                        }
                        Button("command ⌘") {
                            vs.send(.updateMouseModifier(.cmd))
                        }
                    }
                }
                Section {
                    Divider()
                    Section(header: Text("Left Click + Mouse Modifier Action").bold()) {
                        HStack {
                            Button("Move") {
                                vs.send(.updateMouseAction1(.move))
                            }
                            Button("Resize") {
                                vs.send(.updateMouseAction1(.resize))
                            }
                        }
                    }
                    Divider()
                    Section(header: Text("Right Click + Mouse Modifier Action").bold()) {
                        HStack {
                            Button("Move") {
                                vs.send(.updateMouseAction2(.move))
                            }
                            Button("Resize") {
                                vs.send(.updateMouseAction2(.resize))
                            }
                        }
                    }
                    Divider()
                    Section(header: Text("Drop Action").bold()) {
                        HStack {
                            Button("Swap") {
                                vs.send(.updateMouseDropAction(.swap))
                            }
                            Button("Stack") {
                                vs.send(.updateMouseDropAction(.stack))
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
