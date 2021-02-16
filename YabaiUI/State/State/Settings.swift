//
//  Settings.swift
//  YabaiUI
//
//  Created by Kody Deda on 2/15/21.
//

import ComposableArchitecture

struct Settings {
    struct State: Codable, Equatable {
        var errorString: String = ""

        var globalSettings = GlobalSettings.State()
        var spaceSettings = SpaceSettings.State()
        
        var settingsURL: URL {
            yabaiUIApplicationSupportDirectory
            .appendingPathComponent("settingsData.json")
        }
        var yabaiUIApplicationSupportDirectory: URL {
            let path = FileManager.default
                .urls(for: .applicationSupportDirectory, in: .userDomainMask)[0]
                .appendingPathComponent("YabaiUI")
            
            if !FileManager.default.fileExists(atPath: path.absoluteString) {
                try! FileManager.default
                    .createDirectory(at: path, withIntermediateDirectories: true, attributes: nil)
            }
            return path
        }
    }
    
    enum Action: Equatable {
        case save
        case load
        case globalSettings(GlobalSettings.Action)
        case spaceSettings(SpaceSettings.Action)
    }
    
    struct Environment {
        func save(_ state: Settings.State, to url: URL) -> Result<Bool, Error> {
            do {
                let encoded = try JSONEncoder().encode(state)
                try encoded.write(to: url)
                return .success(true)
            } catch {
                return .failure(error)
            }
        }
        func load(_ state: Settings.State, from url: URL) -> Result<(Settings.State), Error> {
            do {
                let data = try Data(contentsOf: url)
                let decoded = try JSONDecoder().decode(type(of: state), from: data)
                return .success(decoded)
            }
            catch {
                return .failure(error)
            }
        }
    }
}

extension Settings {
    static let reducer = Reducer<State, Action, Environment>.combine(
        GlobalSettings.reducer.pullback(
            state: \.globalSettings,
            action: /Settings.Action.globalSettings,
            environment: { _ in () }
        ),
        SpaceSettings.reducer.pullback(
            state: \.spaceSettings,
            action: /Action.spaceSettings,
            environment: { _ in () }
        ),
        Reducer { state, action, environment in
            switch action {
            
            case .save:
                switch environment.save(state, to: state.settingsURL) {
                case .success:
                    state.errorString = ""
                case let .failure(error):
                    state.errorString = "Error - Failed to save state"
                }
                return .none
                
            case .load:
                switch environment.load(state, from: state.settingsURL) {
                case let .success(decoded):
                    state = decoded
                case let .failure(error):
                    state.errorString = "Error - Failed to load state"
                }
                return .none
                
            case let .globalSettings(subAction):
                return Effect(value: .save)
                
            case let .spaceSettings(subAction):
                return Effect(value: .save)
                
            }
        }
    )
}

extension Settings {
    static let defaultStore = Store(
        initialState: .init(),
        reducer: reducer,
        environment: .init()
    )
}


/*------------------------------------------------------------------------------------------
 YABAI ascii documentation:
 ------------------------------------------------------------------------------------------
 - Section  6.1     - configuring Yabai.
 - Sections 6.2-6.7 - configuring actions to Yabai.

 https://github.com/koekeishiya/yabai/blob/master/doc/yabai.asciidoc#config
 ------------------------------------------------------------------------------------------*/
//
//MARK:- 6.1.3. Space Settings
//
//layout [bsp|stack|float]
//Set the layout of the selected space.
//
//top_padding [<integer number>]
//Padding added at the upper side of the selected space.
//
//bottom_padding [<integer number>]
//Padding added at the lower side of the selected space.
//
//left_padding [<integer number>]
//Padding added at the left side of the selected space.
//
//right_padding [<integer number>]
//Padding added at the right side of the selected space.
//
//window_gap [<integer number>]
//Size of the gap that separates windows for the selected space.

//MARK:- 6.1.2. Global Settings
//
//debug_output [<BOOL_SEL>]
//Enable output of debug information to stdout.
//
//external_bar [<main|all|off>:<top_padding>:<bottom_padding>]
//Specify top and bottom padding for a potential custom bar that you may be running.
//main: Apply the given padding only to spaces located on the main display.
//all: Apply the given padding to all spaces regardless of their display.
//off: Do not apply any special padding.
//
//mouse_follows_focus [<BOOL_SEL>]
//When focusing a window, put the mouse at its center.
//
//focus_follows_mouse [autofocus|autoraise|off]
//Automatically focus the window under the mouse.
//
//window_placement [first_child|second_child]
//Specify whether managed windows should become the first or second leaf-node.
//
//window_topmost [<BOOL_SEL>]
//Make floating windows stay on top.
//
//window_shadow [<BOOL_SEL>|float]
//Draw shadow for windows.
//
//window_opacity [<BOOL_SEL>]
//Enable opacity for windows.
//
//window_opacity_duration [<floating point number>]
//Duration of transition between active / normal opacity.
//
//active_window_opacity [<FLOAT_SEL>]
//Opacity of the focused window.
//
//normal_window_opacity [<FLOAT_SEL>]
//Opacity of an unfocused window.
//
//window_border [<BOOL_SEL>]
//Draw border for windows.
//
//window_border_width [<even integer number>]
//Width of window borders. If the given width is an odd number, it will be incremented by 1.
//
//active_window_border_color [0xAARRGGBB]
//Color of the border of the focused window.
//
//normal_window_border_color [0xAARRGGBB]
//Color of the border of an unfocused window.
//
//insert_feedback_color [0xAARRGGBB]
//Color of the window --insert message selection.
//
//split_ratio [<FLOAT_SEL>]
//Default split ratio.
//
//auto_balance [<BOOL_SEL>]
//Balance the window tree upon change, so that all windows occupy the same area.
//
//mouse_modifier [cmd|alt|shift|ctrl|fn]
//Keyboard modifier used for moving and resizing windows.
//
//mouse_action1 [move|resize]
//Action performed when pressing mouse_modifier + button1.
//
//mouse_action2 [move|resize]
//Action performed when pressing mouse_modifier + button2.
//
//mouse_drop_action [swap|stack]
//Action performed when a bsp-managed window is dropped in the center of some other bsp-managed window.
