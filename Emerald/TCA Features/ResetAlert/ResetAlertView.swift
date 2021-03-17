//
//  ResetAlertView.swift
//  Emerald
//
//  Created by Kody Deda on 3/17/21.
//

import SwiftUI
import ComposableArchitecture

struct ResetAlertView: View {
    let store: Store<ResetAlert.State, ResetAlert.Action>
    
    var body: some View {
        WithViewStore(store) { viewStore in
            VStack {
                Text("Reset?")
                HStack {
                    Button("Cancel") { viewStore.send(.toggleIsActive) }
                    Button("Yes") { viewStore.send(.toggleIsActive) }
                }
            }
            .padding()
        }
    }
}



struct ResetAlertView_Previews: PreviewProvider {
    static var previews: some View {
        ResetAlertView(store: ResetAlert.defaultStore)
    }
}


