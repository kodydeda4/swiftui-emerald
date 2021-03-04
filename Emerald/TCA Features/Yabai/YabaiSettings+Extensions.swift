//
//  YabaiSettings+Extensions.swift
//  Emerald
//
//  Created by Kody Deda on 3/3/21.
//

import Foundation

extension YabaiSettings.State {
    enum ExternalBar: String, Codable, CaseIterable, Identifiable {
        var id: ExternalBar { self }
        case main
        case all
        case off
    }
    enum WindowShadow: String, Codable, CaseIterable, Identifiable {
        var id: WindowShadow { self }
        case on
        case off
        case float
    }
    enum FocusFollowsMouse: String, Codable, CaseIterable, Identifiable {
        var id: FocusFollowsMouse { self }
        case autofocus
        case autoraise
        case off
    }
    enum WindowPlacement: String, Codable, CaseIterable, Identifiable {
        var id: WindowPlacement { self }
        case first_child
        case second_child
    }
    enum MouseModifier: String, Codable, CaseIterable, Identifiable {
        var id: MouseModifier { self }
        case cmd
        case alt
        case shift
        case ctrl
        case fn
    }
    enum MouseAction: String, Codable, CaseIterable, Identifiable {
        var id: MouseAction { self }
        case move
        case resize
    }
    enum MouseDropAction: String, Codable, CaseIterable, Identifiable {
        var id: MouseDropAction { self }
        case swap
        case stack
    }
    enum Layout: String, Codable, CaseIterable, Identifiable {
        var id: Layout { self }
        case float
        case bsp
        case stack
    }
}
