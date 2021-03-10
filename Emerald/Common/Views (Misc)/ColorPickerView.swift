//
//  MyColorPickerView.swift
//  Emerald
//
//  Created by Kody Deda on 3/5/21.
//

import SwiftUI

struct ColorPickerView: View {
    var text: String
    @Binding var selection: CodableColor
     
    init(
        _ text: String,
        _ selection: Binding<CodableColor>
    ) {
        self.text = text
        self._selection = selection
    }
    
    var body: some View {
        VStack {
            ColorPicker("", selection: $selection.color)
                .labelsHidden()
            
            Text(text)
                .font(.system(size: systemFontSize))
        }
    }
}

// MARK:- SwiftUI_Previews
struct MyColorPickerView_Previews: PreviewProvider {
    static var previews: some View {
        ColorPickerView("Description", .constant(CodableColor(color: .accentColor)))
    }
}
