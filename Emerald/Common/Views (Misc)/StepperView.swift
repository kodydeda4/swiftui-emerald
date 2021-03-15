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
    
    @State var hovering = false
    
    init(_ text: String,
         _ value: Binding<Int>,
         range: ClosedRange<Int> = 0...10
    ) {
        self.text = text
        self._value = value
        self.range = range
    }
    
    var body: some View {
        VStack {
            HStack {
                Text("\(value)")
                    .offset(x: 6)
                    .foregroundColor(Color(.textColor).opacity(0.75))
                    
                Spacer()
                
                Stepper("", value: $value, in: range)
                    .opacity(hovering ? 1:0)
            }
            .frame(width: 44)
            .background(Color(.windowBackgroundColor))
            .clipShape(RoundedRectangle(cornerRadius: 6))
            .onHover { isHovered in
                hovering.toggle()
            }

            Text("\(text)")
                .font(.system(size: systemFontSize))
                .foregroundColor(Color(.textColor))
        }
    }
}

// MARK:- SwiftUI_Previews
struct MyStepperView_Previews: PreviewProvider {
    static var previews: some View {
        StepperView("Value", .constant(6))
    }
}
