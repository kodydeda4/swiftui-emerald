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
    @Binding var value: Int
    var width: CGFloat = 160
    
    var body: some View {
        HStack {
            Text(text)
            .lineLimit(1)
                .frame(width: width*0.75)
            
            ValueSlider(value: $value, in: 0...100, step: 1)
                .valueSliderStyle(
                    HorizontalValueSliderStyle(
                        thumbSize: CGSize(width: 12, height: 12)
                    )
                )
                .frame(width: width)
            
            Text("\(value)%")
                .padding(6)
                .frame(width: 50)
                .background(Color.black.opacity(0.25))
                .clipShape(RoundedRectangle(cornerRadius: 6))
            Spacer()
        }
    }
}

// MARK:- SwiftUI_Previews
struct MySliderView_Previews: PreviewProvider {
    static var previews: some View {
        MySliderView(text: "Description", value: .constant(25))
    }
}
