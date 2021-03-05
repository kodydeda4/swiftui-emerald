//
//  MySliderView.swift
//  Emerald
//
//  Created by Kody Deda on 3/5/21.
//

import SwiftUI

struct MySliderView: View {
    var text: String
    @Binding var value: Float
    var width: CGFloat = 300
    
    var body: some View {
        VStack {
            HStack {
                Slider(value: $value, in: 0.01...0.99)
                    .frame(width: width)
                Text("\(Int(value * 100))%")
            }
            Text(text)
        }
    }
}

// MARK:- SwiftUI_Previews
struct MySliderView_Previews: PreviewProvider {
    static var previews: some View {
        MySliderView(text: "Description", value: .constant(25))
    }
}
