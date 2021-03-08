//
//  AboutView.swift
//  Emerald
//
//  Created by Kody Deda on 2/11/21.
//

import SwiftUI
import ComposableArchitecture

struct AboutView: View {
    let store: Store<Root.State, Root.Action>
    
    var body: some View {
        WithViewStore(store) { viewStore in
            List {
                SectionView("Emerald") {
                    Text(viewStore.yabai.version)
                        .foregroundColor(.gray)
                    Text(viewStore.skhd.version)
                        .foregroundColor(.gray)
                    Text(viewStore.homebrew.version.split(separator: "\n").first ?? "")
                        .foregroundColor(.gray)
                }
            }
            .navigationTitle("About")
        }
    }
}

struct AboutView_Previews: PreviewProvider {
    static var previews: some View {
        AboutView(store: Root.defaultStore)
    }
}
