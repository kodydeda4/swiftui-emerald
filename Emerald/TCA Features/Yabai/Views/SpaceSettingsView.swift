//
//  SpaceSettingsView.swift
//  Emerald
//
//  Created by Kody Deda on 3/5/21.
//

import SwiftUI
import ComposableArchitecture

struct SpaceSettingsView: View {
    let store: Store<Yabai.State, Yabai.Action>
    let keyPath = Yabai.Action.keyPath
    
    var body: some View {
        WithViewStore(store) { viewStore in
            SectionView("Space") {
                Picker("Layout", selection: viewStore.binding(keyPath: \.layout, send: keyPath)) {
                    ForEach(Yabai.State.Layout.allCases) {
                        Text($0.rawValue)
                    }
                }.labelsHidden()
                
                Section(header: Text("Padding").bold()) {
                    HStack {
                        Stepper("Top \(viewStore.paddingTop)", value: viewStore.binding(keyPath: \.paddingTop, send: keyPath), in: 0...10)
                            .padding(6)
                            .background(Color.black.opacity(0.25))
                            .clipShape(RoundedRectangle(cornerRadius: 8))
                        
                        Stepper("Bottom \(viewStore.paddingBottom)", value: viewStore.binding(keyPath: \.paddingBottom, send: keyPath), in: 0...10)
                            .padding(6)
                            .background(Color.black.opacity(0.25))
                            .clipShape(RoundedRectangle(cornerRadius: 8))
                        
                        Stepper("Left \(viewStore.paddingLeft)", value: viewStore.binding(keyPath: \.paddingLeft, send: keyPath), in: 0...10)
                            .padding(6)
                            .background(Color.black.opacity(0.25))
                            .clipShape(RoundedRectangle(cornerRadius: 8))
                        
                        Stepper("Right \(viewStore.paddingRight)", value: viewStore.binding(keyPath: \.paddingRight, send: keyPath), in: 0...10)
                            .padding(6)
                            .background(Color.black.opacity(0.25))
                            .clipShape(RoundedRectangle(cornerRadius: 8))
                        
                        Stepper("Gap \(viewStore.windowGap)", value: viewStore.binding(keyPath: \.windowGap, send: keyPath), in: 0...10)
                            .padding(6)
                            .background(Color.black.opacity(0.25))
                            .clipShape(RoundedRectangle(cornerRadius: 8))
                    }
                }
            }
        }
    }
}

// MARK:- SwiftUI_Previews
struct SpaceSettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SpaceSettingsView(store: Yabai.defaultStore)
    }
}
