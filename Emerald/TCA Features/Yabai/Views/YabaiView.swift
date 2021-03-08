//
//  SpaceSettingsView.swift
//  Emerald
//
//  Created by Kody Deda on 2/11/21.
//

import SwiftUI
import ComposableArchitecture

struct YabaiSettingsView: View {
    let store: Store<Yabai.State, Yabai.Action>
    let k = Yabai.Action.keyPath
    
    var body: some View {
        WithViewStore(store) { vs in
            //                List {
            //                    MySliderView(
            //                        text: "Animation Duration",
            //                        value: vs.binding(
            //                            get: \.windowOpacityDuration,
            //                            send: Yabai.Action.updateWindowOpacityDuration),
            //                        isEnabled: vs.windowOpacity
            //                    )
            //                }
            //            }
            HStack {
                DebugConfigFileView(text: vs.asConfig)
                
                List {
                    VStack(alignment: .leading) {
                        SectionView("Debug") {
                            Toggle("Enabled", isOn: vs.binding(keyPath: \.debugOutput, send: k))
                        }
                        SpaceSettingsView(store: store)
                        WindowSettingsView(store: store)
                        MouseSettingsView(store: store)
                        ExternalBarSettingsView(store: store)
                    }
                }
                .navigationTitle("Debug Yabai")
            }
        }
    }
}

// MARK:- YabaiSettingsView_Previews
struct YabaiSettingsView_Previews: PreviewProvider {
    static var previews: some View {
        YabaiSettingsView(store: Yabai.defaultStore)
    }
}
