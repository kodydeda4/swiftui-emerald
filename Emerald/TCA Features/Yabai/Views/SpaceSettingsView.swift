//
//  SpaceSettingsView.swift
//  Emerald
//
//  Created by Kody Deda on 3/5/21.
//

import SwiftUI
import ComposableArchitecture


struct ImageButton: View {
    var text: String
    var action: () -> Void
    var image: Image
    var isEnabled: Bool
    
    var body: some View {
        VStack {
            Button(action: { action() }) {
                image
            }
            
            Text(text)
                //.font(.system(size: systemFontSize))
                .foregroundColor(isEnabled ? Color(.textColor) : Color(.disabledControlTextColor))
        }
    }
}
struct SpaceSettingsView: View {
    let store: Store<Yabai.State, Yabai.Action>
    let k = Yabai.Action.keyPath
    
    var body: some View {
        WithViewStore(store) { vs in
            SectionView("Space") {
                Section(header: Text("Layout").bold()) {
                    Picker(selection: vs.binding(keyPath: \.layout, send: k), label: Text("My Vegetables")) {
                        ForEach(Yabai.State.Layout.allCases) { v in
                            //Image(systemName: "rectangle.grid.2x2.fill")
                            Text(v.rawValue)
                        }
                    }
                    .labelsHidden()
                    .pickerStyle(SegmentedPickerStyle())
                    .frame(width: 200)
//                    HStack {
//                        ImageButton(text: "Floating",
//                                    action: { vs.send(.updateLayout(.float)) },
//                                    image: Image(systemName: "rectangle.3.offgrid.fill"),
//                                    isEnabled: vs.layout == .float
//                        )
//                        ImageButton(text: "Tiling",
//                                    action: { vs.send(.updateLayout(.bsp)) },
//                                    image: Image(systemName: "rectangle.grid.2x2.fill"),
//                                    isEnabled: vs.layout == .bsp
//                        )
//
//                        ImageButton(text: "Stacking",
//                                    action: { vs.send(.updateLayout(.stack)) },
//                                    image: Image(systemName: "rectangle.stack.fill"),
//                                    isEnabled: vs.layout == .stack
//                        )
//                    }
                }
                Divider()
                Section(header: Text("Padding").bold()) {
                    HStack {
                        StepperView(text: "Top",    value: vs.binding(keyPath: \.paddingTop,    send: k), isEnabled: true)
                        StepperView(text: "Bottom", value: vs.binding(keyPath: \.paddingBottom, send: k), isEnabled: true)
                        StepperView(text: "Left",   value: vs.binding(keyPath: \.paddingLeft,   send: k), isEnabled: true)
                        StepperView(text: "Right",  value: vs.binding(keyPath: \.paddingRight,  send: k), isEnabled: true)
                        StepperView(text: "Gaps",   value: vs.binding(keyPath: \.windowGap,     send: k), isEnabled: true)
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
