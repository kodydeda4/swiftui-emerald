//
//  EmeraldApp.swift
//  YabaiUI
//
//  Created by Kody Deda on 2/7/21.
//

import SwiftUI

@main
struct EmeraldApp: App {
    var body: some Scene {
        WindowGroup {
            RootView(store: Root.defaultStore)
        }
    }
}
