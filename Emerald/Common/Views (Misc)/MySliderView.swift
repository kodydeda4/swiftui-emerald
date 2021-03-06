//
//  MySliderView.swift
//  Emerald
//
//  Created by Kody Deda on 3/5/21.
//

import SwiftUI
import Sliders

struct MySliderView: View {
    var text: String
    @Binding var value: Float
    var width: CGFloat = 160
    
    
    var body: some View {
        VStack {
            HStack {
                Text(text)
                ValueSlider(value: $value)
                    .valueSliderStyle(HorizontalValueSliderStyle(thumbSize: CGSize(width: 12, height: 12)))
                    .frame(width: width)
                
                Text("\(Int(value * 100))%")
            }
        }
    }
}

// MARK:- SwiftUI_Previews
struct MySliderView_Previews: PreviewProvider {
    static var previews: some View {
        MySliderView(text: "Description", value: .constant(25))
    }
}
