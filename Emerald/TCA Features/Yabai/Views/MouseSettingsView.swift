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
                Section(header: Text("Modifier Key").bold()) {
                    HStack {
                        Button("fn") {
                            vs.send(.updateMouseModifier(.fn))
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
                        Button("shift ⇧") {
                            vs.send(.updateMouseModifier(.shift))
                        }
                    }
                }
                Section {
                    Divider()
                    Section(header: Text("Left Click + Modifier").bold()) {
                        Picker("", selection: vs.binding(keyPath: \.mouseAction1, send: k)) {
                            ForEach(Yabai.State.MouseAction.allCases) {
                                Text($0.rawValue)
                            }
                        }
                        .labelsHidden()
                        .pickerStyle(SegmentedPickerStyle())
                        .frame(width: 100)
                    }
                    Divider()
                    Section(header: Text("Right Click + Modifier").bold()) {
                        Picker("", selection: vs.binding(keyPath: \.mouseAction2, send: k)) {
                            ForEach(Yabai.State.MouseAction.allCases) {
                                Text($0.rawValue)
                            }
                        }
                        .labelsHidden()
                        .pickerStyle(SegmentedPickerStyle())
                        .frame(width: 100)
                    }
                    Divider()
                    Section(header: Text("Drop Action").bold()) {
                        Picker("", selection: vs.binding(keyPath: \.mouseDropAction, send: k)) {
                            ForEach(Yabai.State.MouseDropAction.allCases) {
                                Text($0.rawValue)
                            }
                        }
                        .labelsHidden()
                        .pickerStyle(SegmentedPickerStyle())
                        .frame(width: 100)
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
