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
            HStack {
                Text("\(value)")
                    .offset(x: 6)
                    .foregroundColor(isEnabled ? Color(.textColor) : Color(.disabledControlTextColor))
                    
                Spacer()
                Stepper("", value: $value, in: range)
                    .disabled(!isEnabled)
                    //.padding(1)
                    //.padding(.leading, 20)
                    //.frame(width: 53)

            }
            .frame(width: 44)
            .background(Color(.windowBackgroundColor))
            .clipShape(RoundedRectangle(cornerRadius: 6))

            //.frame(width: 53)
                
            Text("\(text)")
                .font(.system(size: systemFontSize))
                .foregroundColor(isEnabled ? Color(.textColor) : Color(.disabledControlTextColor))
        }
        //.frame(width: 53)
    }
}

// MARK:- SwiftUI_Previews
struct MyStepperView_Previews: PreviewProvider {
    static var previews: some View {
        StepperView(text: "Value", value: .constant(6), isEnabled: true)
    }
}
