//
//  ApplyingChangesView.swift
//  Emerald
//
//  Created by Kody Deda on 3/17/21.
//

import SwiftUI
import ComposableArchitecture

struct ApplyingChangesView: View {
    let store: Store<Root.State, Root.Action>
    
    var body: some View {
        WithViewStore(store) { viewStore in
            VStack {
                Text("Put an animation here")
                
                Button("finish (should debounce after like 3 seconds") {
                    viewStore.send(.applyingChanges)
                }
            }
            .padding()
        }
    }
}

struct ApplyingChangesView_Previews: PreviewProvider {
    static var previews: some View {
        ApplyingChangesView(store: Root.defaultStore)
    }
}
