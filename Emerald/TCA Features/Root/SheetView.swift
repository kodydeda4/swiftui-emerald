//
//  SheetView.swift
//  Emerald
//
//  Created by Kody Deda on 3/24/21.
//

import SwiftUI
import ComposableArchitecture

struct SheetView: View {
  let store: Store<Root.State, Root.Action>
  
  var body: some View {
    WithViewStore(store) { viewStore in
      if viewStore.animatingApplyChanges {
        ApplyChangesButtonTappedView(store: store)
      } else if viewStore.animatingTogglePower {
        PowerButtonTappedView(store: store)
      } else {
        Text("Default")
          .padding()
      }
    }
  }
}

struct SheetView_Previews: PreviewProvider {
  static var previews: some View {
    SheetView(store: Root.defaultStore)
  }
}
