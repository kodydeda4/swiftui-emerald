//
//  Onboarding.swift
//  Emerald
//
//  Created by Kody Deda on 2/11/21.
//

import SwiftUI
import ComposableArchitecture

struct Feature: Identifiable, Equatable {
  var id = UUID()
  let name: String
  let image: Image
  let description: String
}

struct Onboarding {
  struct State: Equatable {
    var isOnboaring = true
    var currentPage: onboardingPage = .first
    
    enum onboardingPage {
      case first
      case second
      case third
    }
    
    let features: [Feature] = [
      Feature(
        name: "Window Shadows",
        image: Image(systemName: "sun.max.fill"),
        description: "Toggle shadows on/off"
      ),
      Feature(
        name: "Window Borders",
        image: Image(systemName: "paintbrush"),
        description: "Apply colored borders to any app"
      ),
      Feature(
        name: "Window Transparency",
        image: Image(systemName: "macwindow"),
        description: "Set active and inactive transparency"
      ),
      Feature(
        name: "Picture-in-Picture",
        image: Image(systemName: "play.circle"),
        description: "Enable pip for all windows"
      ),
      Feature(
        name: "Sticky-Windows",
        image: Image(systemName: "display.2"),
        description: "Create windows that appear in all spaces"
      ),
      Feature(
        name: "Float Ontop",
        image: Image(systemName: "square.3.stack.3d.top.fill"),
        description: "Set floating windows to always-on-top"
      ),
    ]
  }
  enum Action: Equatable {
    case toggleIsOnboaring
  }
}

extension Onboarding {
  static let reducer = Reducer<State, Action, Void> {
    state, action, _ in
    switch action {
    
    case .toggleIsOnboaring:
      state.isOnboaring.toggle()
      return .none
      
    }
  }
}

extension Onboarding {
  static let defaultStore = Store(
    initialState: .init(),
    reducer: reducer,
    environment: ()
  )
}
