//
//  FocusSettingsView.swift
//  Emerald
//
//  Created by Kody Deda on 3/9/21.
//

import SwiftUI
import ComposableArchitecture

struct FocusSettingsView: View {
    let store: Store<Yabai.State, Yabai.Action>
    let k = Yabai.Action.keyPath
    
    var body: some View {
        WithViewStore(store) { vs in
            VStack(alignment: .leading, spacing: 20) {
                
                // AutoFocus
                VStack(alignment: .leading) {
                    HStack {
                        Group {
                            Toggle("", isOn: vs.binding(\.focusFollowsMouseEnabled, k))
                                .labelsHidden()
                            
                            Text("Auto Focus")
                                .bold().font(.title3)
                        }
                        .disabled(vs.sipEnabled)
                        .opacity(vs.sipEnabled ? 0.5 : 1.0)
                        
                        Spacer()
                        SIPButton(store: Root.defaultStore)
                    }
                    Picker("", selection: vs.binding(\.focusFollowsMouse, k)) {
                        ForEach(Yabai.State.FocusFollowsMouse.allCases) {
                            Text($0.rawValue)
                        }
                    }
                    .labelsHidden()
                    .pickerStyle(SegmentedPickerStyle())
                    .frame(width: 150)
                    .disabled(!vs.focusFollowsMouseEnabled || vs.sipEnabled)
                    .opacity( !vs.focusFollowsMouseEnabled || vs.sipEnabled ? 0.5 : 1.0)

                    Text("Repellendus est dicta facere aut. Et quisquam dicta voluptatum laboriosam amet reiciendis earum. Quaerat autem tenetur dolores optio consequatur.")
                        .foregroundColor(Color(.gray))
                        .disabled(vs.sipEnabled)
                        .opacity( vs.sipEnabled ? 0.5 : 1.0)
                }
                
                // Follow Focus
                VStack(alignment: .leading) {
                    Divider()
                    HStack {
                        Group {
                            Toggle("Enabled", isOn: vs.binding(\.mouseFollowsFocus, k))
                                .labelsHidden()
                            
                            Text("Follow Focus")
                                .bold().font(.title3)
                        }
                        .disabled(vs.sipEnabled)
                        .opacity( vs.sipEnabled ? 0.5 : 1.0)

                        Spacer()
                        SIPButton(store: Root.defaultStore)
                    }
                    Text("Repellendus est dicta facere aut. Et quisquam dicta voluptatum laboriosam amet reiciendis earum. Quaerat autem tenetur dolores optio consequatur.")
                        .foregroundColor(Color(.gray))
                        .disabled(vs.sipEnabled)
                        .opacity( vs.sipEnabled ? 0.5 : 1.0)
                }
                Spacer()
            }
            .padding()
            .navigationTitle("Space")
        }
    }
}


// MARK:- SwiftUI_Previews
struct FocusSettingsView_Previews: PreviewProvider {
    static var previews: some View {
        FocusSettingsView(store: Yabai.defaultStore)
    }
}

