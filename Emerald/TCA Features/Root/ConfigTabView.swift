//
//  ConfigTabView.swift
//  Emerald
//
//  Created by Kody Deda on 3/17/21.
//

import SwiftUI
import ComposableArchitecture

struct ConfigTabView: View {
  let store: Store<Root.State, Root.Action>
  
  var body: some View {
    WithViewStore(store) { viewStore in
      TabView {
        DebugConfigFileView(text: viewStore.yabai.asConfig)
          .tabItem { Label("Yabai", systemImage: "square.and.pencil") }
        
        DebugConfigFileView(text: viewStore.skhd.asConfig)
          .tabItem { Label("SKHD", systemImage: "square.and.pencil") }
      }
      .padding()
    }
  }
}

struct ConfigTabView_Previews: PreviewProvider {
  static var previews: some View {
    ConfigTabView(store: Root.defaultStore)
  }
}

