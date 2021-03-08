//
//  MyStepperView.swift
//  Emerald
//
//  Created by Kody Deda on 3/5/21.
//

import SwiftUI

public let systemFontSize: CGFloat = 10

struct StepperView: View {
    let text: String
    @Binding var value: Int
    let range: ClosedRange<Int>
    var isEnabled: Bool
    
    init(text: String,
         value: Binding<Int>,
         range: ClosedRange<Int> = 0...10,
         isEnabled: Bool
    ) {
        self.text = text
        self._value = value
        self.range = range
        self.isEnabled = isEnabled
    }
    
    var body: some View {
        VStack {
            Stepper("\(value)", value: $value, in: range)
                .disabled(!isEnabled)
                .foregroundColor(isEnabled ? Color(NSColor.textColor) : Color(NSColor.disabledControlTextColor))
                .padding(1)
                .padding(.leading)
                //.frame(width: 100)
                .background(Color(NSColor.windowBackgroundColor))
                .clipShape(RoundedRectangle(cornerRadius: 6))
                
            Text("\(text)")
                .font(.system(size: systemFontSize))
                .foregroundColor(isEnabled ? Color(NSColor.textColor) : Color(NSColor.disabledControlTextColor))
        }
    }
}

// MARK:- SwiftUI_Previews
struct MyStepperView_Previews: PreviewProvider {
    static var previews: some View {
        StepperView(text: "Value", value: .constant(6), isEnabled: true)
    }
}
