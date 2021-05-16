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
    
    var body: some View {
        WithViewStore(store) { vs in
            VStack(alignment: .leading) {
                
                // AutoFocus
                VStack(alignment: .leading) {
                    Text("Mouse Focus")
                        .bold().font(.title3)

                    Picker("", selection: vs.binding(keyPath: \.focusFollowsMouse, send: Yabai.Action.keyPath)) {
                        ForEach(Yabai.State.FocusFollowsMouse.allCases) {
                            Text($0.rawValue)
                        }
                    }
                    .labelsHidden().pickerStyle(SegmentedPickerStyle()).frame(width: 200)

                    Text(vs.focusFollowsMouse.caseDescription)
                        .foregroundColor(Color(.gray))
                }
                
                // Follow Focus
                VStack(alignment: .leading) {
                    Divider()
                    HStack {
                        Group {
                            Toggle("Enabled", isOn: vs.binding(keyPath: \.mouseFollowsFocus, send: Yabai.Action.keyPath))
                                .labelsHidden()
                            
                            Text("Follow Focus")
                                .bold().font(.title3)
                        }
                        Spacer()
                        SIPButton(store: Root.defaultStore)
                    }
                    
                    Text("Mouse will automatically reposition itself to center of focused window")
                        .foregroundColor(Color(.gray))
                }
                Spacer()
            }
            .padding()
        }
    }
}


// MARK:- SwiftUI_Previews
struct FocusSettingsView_Previews: PreviewProvider {
    static var previews: some View {
        FocusSettingsView(store: Yabai.defaultStore)
    }
}

