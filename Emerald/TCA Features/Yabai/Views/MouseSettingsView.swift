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
  
  var body: some View {
    WithViewStore(store) { viewStore in
      ScrollView {
        
        // Left Click + Modifier
        VStack {
          Text("Left Click + Modifier").bold().font(.title3)
          Text(viewStore.mouseAction1.caseDescription).foregroundColor(Color(.gray))
          
          Picker("", selection: viewStore.binding(keyPath: \.mouseAction1, send: Yabai.Action.keyPath)) {
            ForEach(Yabai.State.MouseAction.allCases) {
              Text($0.rawValue)
            }
          }
          .labelsHidden().pickerStyle(SegmentedPickerStyle()).frame(width: 100)
          
        }
        .padding()
        
        // Right Click + Modifier
        VStack {
          Text("Right Click + Modifier").bold().font(.title3)
          Text(viewStore.mouseAction2.caseDescription).foregroundColor(Color(.gray))
          
          Picker("", selection: viewStore.binding(keyPath: \.mouseAction2, send: Yabai.Action.keyPath)) {
            ForEach(Yabai.State.MouseAction.allCases) { Text($0.rawValue) }
          }
          .labelsHidden().pickerStyle(SegmentedPickerStyle()).frame(width: 100)
          
        }
        .padding()
        
        // Modifier Key
        VStack {
          Text("Modifier Key").bold().font(.title3)
          Text("Press & hold for mouse actions").foregroundColor(Color(.gray))
          
          Picker("", selection: viewStore.binding(keyPath: \.mouseModifier, send: Yabai.Action.keyPath)) {
            ForEach(Yabai.State.MouseModifier.allCases) {
              Text($0.labelDescription.lowercased())
            }
          }
          .labelsHidden().pickerStyle(SegmentedPickerStyle()).frame(width: 350)
          
        }
        .padding()
        
        // DropAction
        VStack {
          Text("Drop Action").bold().font(.title3)
          
          Picker("", selection: viewStore.binding(keyPath: \.mouseDropAction, send: Yabai.Action.keyPath)) {
            ForEach(Yabai.State.MouseDropAction.allCases) {
              Text($0.rawValue)
            }
          }
          .labelsHidden()
          .pickerStyle(SegmentedPickerStyle())
          .frame(width: 100)
          
          Text(viewStore.mouseDropAction.caseDescription).foregroundColor(Color(.gray))
        }
        .padding()
        
        // AutoFocus
        VStack {
          Text("Mouse Focus").bold().font(.title3)
          
          Picker("", selection: viewStore.binding(keyPath: \.focusFollowsMouse, send: Yabai.Action.keyPath)) {
            ForEach(Yabai.State.FocusFollowsMouse.allCases) {
              Text($0.labelDescription.lowercased())
            }
          }
          .labelsHidden().pickerStyle(SegmentedPickerStyle()).frame(width: 250)
          
          Text(viewStore.focusFollowsMouse.caseDescription).foregroundColor(Color(.gray))
        }
        .padding()
        
        // Follow Focus
        VStack {
          HStack {
            Toggle("Enabled", isOn: viewStore.binding(keyPath: \.mouseFollowsFocus, send: Yabai.Action.keyPath)).labelsHidden()
            Text("Follow Focus").bold().font(.title3)
          }
          
          Text("Mouse will automatically reposition itself to center of focused window")
            .foregroundColor(Color(.gray))
        }
        .padding()
      }
      .frame(alignment: .leading)
      .frame(maxWidth: 900)
    }
  }
}




// MARK:- SwiftUI_Previews
struct MouseSettingsView_Previews: PreviewProvider {
  static var previews: some View {
    MouseSettingsView(store: Yabai.defaultStore)
  }
}
