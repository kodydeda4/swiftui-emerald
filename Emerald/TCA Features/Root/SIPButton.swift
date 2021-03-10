//
//  SIPButton.swift
//  Emerald
//
//  Created by Kody Deda on 3/9/21.
//

import SwiftUI
import ComposableArchitecture

struct SIPButton: View {
    let store: Store<Root.State, Root.Action>
    
    var body: some View {
        WithViewStore(store) { viewStore in
            Button(action: { viewStore.send(.onboarding(.toggleIsOnboaring)) }) {
                HStack {
                    Image(systemName: "lock.fill")
                    Text("SIP Enabled")
                }
                .foregroundColor(.accentColor)
            }
            .buttonStyle(PlainButtonStyle())
        }
    }
}

// MARK:- SwiftUI_Previews
struct SIPButton_Previews: PreviewProvider {
    static var previews: some View {
        SIPButton(store: Root.defaultStore)
    }
}
