//
//  SKHDSettingsView.swift
//  Emerald
//
//  Created by Kody Deda on 2/17/21.
//

import SwiftUI
import ComposableArchitecture
import KeyboardShortcuts

struct SKHDSettingsView: View {
    let store: Store<Root.State, Root.Action>
    
    var body: some View {
        WithViewStore(store) { vs in
            VStack(alignment: .leading) {
                SectionView("SKHD Shortcuts") {
                    MyKeyboardShortcutsView("float  ",   .float  )   { vs.send(.skhd(.updateFloat(   $0))) }
                    MyKeyboardShortcutsView("bsp    ",   .bsp    )   { vs.send(.skhd(.updateBsp(     $0))) }
                    MyKeyboardShortcutsView("stack  ",   .stack  )   { vs.send(.skhd(.updateStack(   $0))) }
                    MyKeyboardShortcutsView("focus  ",   .focus  )   { vs.send(.skhd(.updateFocus(   $0))) }
                    MyKeyboardShortcutsView("resize ",   .resize )   { vs.send(.skhd(.updateResize(  $0))) }
                    MyKeyboardShortcutsView("move   ",   .move   )   { vs.send(.skhd(.updateMove(    $0))) }
                    MyKeyboardShortcutsView("split  ",   .split  )   { vs.send(.skhd(.updateSplit(   $0))) }
                    MyKeyboardShortcutsView("balance",   .balance)   { vs.send(.skhd(.updateBalance( $0))) }
                    MyKeyboardShortcutsView("padding",   .padding)   { vs.send(.skhd(.updatePadding( $0))) }
                    MyKeyboardShortcutsView("gaps   ",   .gaps   )   { vs.send(.skhd(.updateGaps(    $0))) }
                    
                    
                    
//                        MyKeyboardShortcutsView("Toggle Padding",  .togglePadding)  { vs.send(.updateTogglePadding( $0)) }
//                        MyKeyboardShortcutsView("Toggle Gaps",     .toggleGaps)     { vs.send(.updateToggleGaps(    $0)) }
//                        MyKeyboardShortcutsView("Toggle Split",    .toggleSplit)    { vs.send(.updateToggleSplit(   $0)) }
//                        MyKeyboardShortcutsView("Toggle Balance",  .toggleBalance)  { vs.send(.updateToggleBalance( $0)) }
//                        MyKeyboardShortcutsView("Toggle Stacking", .toggleStacking) { vs.send(.updateToggleStacking($0)) }
//                        MyKeyboardShortcutsView("Toggle Floating", .toggleFloating) { vs.send(.updateToggleFloating($0)) }
//                        MyKeyboardShortcutsView("Toggle BSP",      .toggleBSP)      { vs.send(.updateToggleBSP(     $0)) }
                }
            }
            .navigationTitle("Debug SKHD")
        }
    }
}

struct SKHDSettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SKHDSettingsView(store: Root.defaultStore)
    }
}

