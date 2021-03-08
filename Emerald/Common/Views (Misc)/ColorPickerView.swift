//
//  MyColorPickerView.swift
//  Emerald
//
//  Created by Kody Deda on 3/5/21.
//

import SwiftUI

struct ColorPickerView: View {
    var text: String
    @Binding var selection: Color
    
    var body: some View {
        VStack {
            ColorPicker("", selection: $selection).labelsHidden()
            Text(text)
                .font(.system(size: systemFontSize))
        }
    }
}

// MARK:- SwiftUI_Previews
struct MyColorPickerView_Previews: PreviewProvider {
    static var previews: some View {
        ColorPickerView(text: "Description", selection: .constant(.accentColor))
    }
}
