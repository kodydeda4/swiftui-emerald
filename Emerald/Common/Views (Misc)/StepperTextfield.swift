//
//  MyStepperView.swift
//  Emerald
//
//  Created by Kody Deda on 3/5/21.
//

import SwiftUI

public let systemFontSize: CGFloat = 10

struct StepperTextfield: View {
    let text: String
    @Binding var value: Int
    let range: ClosedRange<Int>
    
    init(_ text: String,
         _ value: Binding<Int>,
         range: ClosedRange<Int> = 0...20
    ) {
        self.text = text
        self._value = value
        self.range = range
    }
    
    var body: some View {
        VStack {
            TextField(text, value: $value, formatter: NumberFormatter())
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .overlay(
                    HStack {
                        Spacer()
                        Stepper("", value: $value, in: range)
                    }
                )
            Text(text)
                .font(.caption)
            
        }
    }
}



// MARK:- SwiftUI_Previews
struct MyStepperView_Previews: PreviewProvider {
    static var previews: some View {
        StepperTextfield("Value", .constant(6))//, isEnabled: true)
    }
}
