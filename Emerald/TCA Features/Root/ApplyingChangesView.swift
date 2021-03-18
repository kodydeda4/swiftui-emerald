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
    
    @State var opacity = true
    
    var body: some View {
        WithViewStore(store) { viewStore in
            Text("Applying Changes")
                .padding()
                .opacity(opacity ? 1 : 0)
                .animation(Animation.easeOut(duration: 1).repeatForever(), value: opacity)
                .onAppear { opacity.toggle() }
        }
    }
}

struct ApplyingChangesView_Previews: PreviewProvider {
    static var previews: some View {
        ApplyingChangesView(store: Root.defaultStore)
    }
}

