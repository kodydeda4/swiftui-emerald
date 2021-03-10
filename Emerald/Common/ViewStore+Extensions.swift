//
//  ViewStore+Extensions.swift
//  Emerald
//
//  Created by Kody Deda on 3/10/21.
//

import SwiftUI
import ComposableArchitecture

///MARK:- Binding without argument labels.
extension ViewStore {
  public func binding<LocalState>(
    _ keyPath: WritableKeyPath<State, LocalState>,
    _ action: @escaping (BindingAction<State>) -> Action
  ) -> Binding<LocalState>
  where LocalState: Equatable {
    self.binding(
      get: { $0[keyPath: keyPath] },
      send: { action(.set(keyPath, $0)) }
    )
  }
}


