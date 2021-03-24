//
//  TogglingActiveView.swift
//  Emerald
//
//  Created by Kody Deda on 3/18/21.
//

import SwiftUI
import ComposableArchitecture

struct PowerButtonTappedView: View {
    let store: Store<Root.State, Root.Action>
    
    @State var opacity = true
    
    var body: some View {
        WithViewStore(store) { viewStore in
            VStack {
                Image(systemName: "power")
                    .resizable()
                    .scaledToFit()
                    .foregroundColor(viewStore.disabled ? .red : .green)
                    .frame(width: 50, height: 50)
                
                Text(viewStore.disabled ? "Shutting Down" : "Starting Up")
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

struct PowerButtonTappedView_Previews: PreviewProvider {
    static var previews: some View {
        PowerButtonTappedView(store: Root.defaultStore)
    }
}

