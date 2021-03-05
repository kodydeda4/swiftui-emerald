//
//  MyStepperView.swift
//  Emerald
//
//  Created by Kody Deda on 3/5/21.
//

import SwiftUI

struct MyStepperView: View {
    let text: String
    @Binding var value: Int
    let range: ClosedRange<Int>
    
    init(_ text: String,
         value: Binding<Int>,
         range: ClosedRange<Int> = 0...10
    ) {
        self.text = text
        self._value = value
        self.range = range
    }
    
    var body: some View {
        Stepper("\(text) \(value)", value: $value, in: range)
            .padding(6)
            .background(Color.black.opacity(0.25))
            .clipShape(RoundedRectangle(cornerRadius: 8))
    }
}

// MARK:- SwiftUI_Previews
struct MyStepperView_Previews: PreviewProvider {
    static var previews: some View {
        MyStepperView("Value", value: .constant(6))
    }
}
