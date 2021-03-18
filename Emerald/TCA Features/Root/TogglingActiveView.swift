//
//  TogglingActiveView.swift
//  Emerald
//
//  Created by Kody Deda on 3/18/21.
//

import SwiftUI
import ComposableArchitecture

struct TogglingActiveView: View {
    let store: Store<Root.State, Root.Action>
    
    @State var opacity = true
    
    var body: some View {
        WithViewStore(store) { viewStore in
            VStack {
                Image(systemName: "power")
                    .resizable()
                    .scaledToFit()
                    .foregroundColor(viewStore.enabled ? .green : .red)
                    .frame(width: 50, height: 50)
                
                Text(viewStore.enabled ? "Starting Up" : "Shutting Down")
                    .font(.title)
                    .fontWeight(.medium)
                    .padding()
            }
            .padding(30)
            .opacity(opacity ? 1 : 0)
            .animation(Animation.easeInOut(duration: 1).repeatForever(), value: opacity)
            .onAppear { opacity.toggle() }

        }
    }
}

struct TogglingActiveView_Previews: PreviewProvider {
    static var previews: some View {
        TogglingActiveView(store: Root.defaultStore)
    }
}

