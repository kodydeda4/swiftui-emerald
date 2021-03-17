//
//  Button+Extensions.swift
//  Emerald
//
//  Created by Kody Deda on 3/17/21.
//

import SwiftUI

/// Create a Button with an SF Symbol
extension Button {
    init(_ systemImage: String, action: @escaping () -> Void) {
        self.init(
            action: action,
            label: { Image(systemName: systemImage) as! Label }
        )
    }
}

struct Button_Extensions_Previews: PreviewProvider {
    static var previews: some View {
        Button<Image>("keyboard") {
            // Action
        }
    }
}
