//
//  AboutView.swift
//  YabaiUI
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
                VStack(alignment: .leading) {
                    Text("Authors")
                    Text("Team Alpha - Kody Deda, Zane Bernard, Zachary Mitzke, Robin Wood, Paolo Imperio")
                        .foregroundColor(.gray)
                }
                
                Divider()
                
                VStack(alignment: .leading) {
                    Text("Yabai Version")
                    Text(viewStore.yabaiVersion)
                        .foregroundColor(.gray)
                }
                
                VStack(alignment: .leading) {
                    Text("SKHD Version")
                    Text(viewStore.skhdVersion)
                        .foregroundColor(.gray)
                }
                
                VStack(alignment: .leading) {
                    Text("HomeBrew Version")
                    Text(viewStore.brewVersion)
                        .foregroundColor(.gray)
                        .lineLimit(1)
                }
            }
        }
    }
}

struct AboutView_Previews: PreviewProvider {
    static var previews: some View {
        AboutView(store: Root.defaultStore)
    }
}
