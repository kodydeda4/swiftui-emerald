//
//  RootView.swift
//  Emerald
//
//  Created by Kody Deda on 2/12/21.
//

import SwiftUI
import ComposableArchitecture

struct RootView: View {
    let store: Store<Root.State, Root.Action>
    
    var body: some View {
        WithViewStore(store) { viewStore in
            NavigationView {
                SidebarView(store: store)
            }
            .disabled(viewStore.disabled)
            .onAppear {
                viewStore.send(.onAppear)
            }
            .sheet(isPresented: viewStore.binding(get: \.sheetView, send: .toggleSheetView)) {
                SheetView(store: store)
            }
            .alert(store.scope(state: \.alert), dismiss: .dismissResetAlert)
            .toolbar {
                ToolbarItem {
                    Button<Image>("sidebar.left") {
                        viewStore.send(.sidebarButtonTapped)
                    }
                    .disabled(viewStore.disabled)
                }
                ToolbarItem {
                    Button("Install Programs") {
                        viewStore.send(.installProgramsButtonTapped)
                    }
                    .help("⇧ ⌘ A")
                    .keyboardShortcut("a", modifiers: [.command, .shift])
                    .disabled(viewStore.disabled)
                }
                ToolbarItem {
                    Button("Reset") {
                        viewStore.send(.resetButtonTapped)
                    }
                    .help("⇧ ⌘ R")
                    .keyboardShortcut("r", modifiers: [.command, .shift])
                    .disabled(viewStore.disabled)
                }
                ToolbarItem {
                    Button("Apply Changes") {
                        viewStore.send(.applyChangesButtonTapped)
                    }
                    .help("⇧ ⌘ A")
                    .keyboardShortcut("a", modifiers: [.command, .shift])
                    .disabled(viewStore.disabled)
                }

                ToolbarItem {
                    Button<Image>("power") {
                        viewStore.send(.powerButtonTapped)
                    }
                    .help("\(viewStore.disabled ? "Enable" : "Disable") Emerald")
                    .foregroundColor(viewStore.disabled ? .red : .accentColor)
                }
            }
        }
    }
}

struct ChildTabView: View {
    var title: String
    var index: Int
    
    var body: some View {
        Text("\(title) - Index \(index)")
            .padding()
    }
}



struct RootView_Previews: PreviewProvider {
    static var previews: some View {
        RootView(store: Root.defaultStore)
    }
}
