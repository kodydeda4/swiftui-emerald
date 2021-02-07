//
//  SpaceSettings.swift
//  YabaiUI
//
//  Created by Kody Deda on 2/7/21.
//

import SwiftUI
import ComposableArchitecture
import Combine

//MARK:- SpaceSettings

/*
 Writes a Yabai layout preference to a file "~/Documents/.output"
 
 Yabai SpaceSettings can be found here:
 https://github.com/koekeishiya/yabai/blob/master/doc/yabai.asciidoc#613-space-settings
 */

enum Layout: String, CaseIterable, Identifiable {
    case bsp
    case stack
    case float
    
    var id: Layout { self }
}

struct SpaceSettings {
    struct State: Equatable {
        var layout: Layout = .float
    }
    
    enum Action: Equatable {
        case updateLayout(Layout)
    }
    
    struct Environment {}
}

extension SpaceSettings {
    static let reducer = Reducer<State, Action, Environment>.combine(
        
        Reducer { state, action, environment in
            switch action {
            
            case let .updateLayout(layout):
                state.layout = layout
                return .none
            
            }
        }
    )
}

extension SpaceSettings {
    static let defaultStore = Store(
        initialState: .init(),
        reducer: reducer,
        environment: .init()
    )
}

// MARK:- SpaceSettingsView

struct SpaceSettingsView: View {
    let store: Store<SpaceSettings.State, SpaceSettings.Action>
    
    var body: some View {
        WithViewStore(store) { viewStore in
            List {
                Section(header: Text("Space Settings")) {
                    

                    Picker(selection: viewStore.binding(
                            get: \.layout,
                            send: SpaceSettings.Action.updateLayout),

                    label: Text("Layout")) {
                        ForEach(Layout.allCases) {
                            Text($0.rawValue)
                        }
                    }
                }
                
            }
            .navigationTitle("YabaiUI")
            .toolbar {
                ToolbarItem {
                    Button("Apply Changes") {
                        writeToFile(contents: "Yabai -m config \(viewStore.layout)")

                    }
                }
            }
        }
    }
}

struct SpaceSettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SpaceSettingsView(store: SpaceSettings.defaultStore)
    }
}


func writeToFile(contents: String) {
    let filename =
        getDocumentsDirectory()
        .appendingPathComponent(".output")

    do {
        try contents.write(
            to: filename,
            atomically: true,
            encoding: String.Encoding.utf8
        )
    } catch {
        /* failed to write file:
            - bad permissions,
            - bad filename,
            - missing permissions,
         or more likely:
            it can't be converted to the encoding */
    }
}

func getDocumentsDirectory() -> URL {
    let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
    return paths[0]
}
