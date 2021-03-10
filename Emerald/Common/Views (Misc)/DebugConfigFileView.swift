//
//  ConfigFileView.swift
//  Emerald
//
//  Created by Kody Deda on 2/24/21.
//

import SwiftUI

struct DebugConfigFileView: View {
    let text: String
    
    var body: some View {
        ScrollView {
            VStack {
                Text(text)
                    .font(.system(size: 11, design: .monospaced))
                    .foregroundColor(.accentColor)
                    .frame(width: 380, alignment: .leading)

            }
            .padding()
            .background(Color.black)
            .border(Color.accentColor)
        }
        .padding()
    }
}

struct DebugConfigFileView_Previews: PreviewProvider {
    static var previews: some View {
        DebugConfigFileView(
            text: [
                "preference A",
                "preference B",
                "preference C",
            ]
            .joined(separator: "\n")
        )
    }
}
