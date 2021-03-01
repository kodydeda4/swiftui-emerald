//
//  ConfigFileView.swift
//  YabaiUI
//
//  Created by Kody Deda on 2/24/21.
//

import SwiftUI

struct ConfigFileView: View {
    let text: String
    
    var body: some View {
        ScrollView {
            VStack {
                Text(text)
                    .font(.system(size: 11, design: .monospaced))
                    .foregroundColor(.accentColor)
            }
            .padding()
            .background(Color.black)
            .border(Color.accentColor)

        }
        .padding()
    }
}

struct ConfigFileView_Previews: PreviewProvider {
    static var previews: some View {
        ConfigFileView(text: confgText)
    }
}

private var confgText: String {
    [
        "#   ██╗   ██╗ █████╗ ██████╗  █████╗ ██╗",
        "#   ╚██╗ ██╔╝██╔══██╗██╔══██╗██╔══██╗██║",
        "#    ╚████╔╝ ███████║██████╔╝███████║██║",
        "#     ╚██╔╝  ██╔══██║██╔══██╗██╔══██║██║",
        "#      ██║   ██║  ██║██████╔╝██║  ██║██║",
        "#      ╚═╝   ╚═╝  ╚═╝╚═════╝ ╚═╝  ╚═╝╚═╝",
        "#",
        "",
        "#=========================================================================",
        "# Section A",
        "#=========================================================================",
        "preference A",
        "preference B",
        "preference C",
    ]
    .joined(separator: "\n")
}
