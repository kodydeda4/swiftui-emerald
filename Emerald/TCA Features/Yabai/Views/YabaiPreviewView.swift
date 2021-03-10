//
//  YabaiPreview.swift
//  Emerald
//
//  Created by Kody Deda on 3/9/21.
//

import SwiftUI
import ComposableArchitecture

struct YabaiPreviewView: View {
    let store: Store<Yabai.State, Yabai.Action>

    var body: some View {
        WithViewStore(store) { vs in
            DebugConfigFileView(text: vs.asConfig)
//            Rectangle()
//                .foregroundColor(.blue)
        }
    }
}

struct YabaiPreviewView_Previews: PreviewProvider {
    static var previews: some View {
        YabaiPreviewView(store: Yabai.defaultStore)
    }
}
