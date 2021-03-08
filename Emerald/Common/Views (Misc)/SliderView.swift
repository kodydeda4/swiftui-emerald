//
//  MySliderView.swift
//  Emerald
//
//  Created by Kody Deda on 3/5/21.
//

import SwiftUI
import Sliders

struct SliderView: View {
    var text: String
    @Binding var value: Int
    var width: CGFloat = 160
    var isEnabled: Bool
    var hideLabel = false
    
    
    var body: some View {
        HStack {
            if !hideLabel {
            Text(text)
                .foregroundColor(isEnabled ? Color(.controlTextColor) : Color(.disabledControlTextColor))
                .lineLimit(1)
                .frame(width: width*0.8)
            }
                
            ValueSlider(
                value: $value,
                in: 0...100,
                step: 1
            )
            .disabled(!isEnabled)
            .drawingGroup()
            
            .valueSliderStyle(
                HorizontalValueSliderStyle(
                    track:
                        HorizontalValueTrack(
                            view: Capsule().foregroundColor(isEnabled ? Color.accentColor : Color(.disabledControlTextColor))
                        )
                        .background(Capsule().foregroundColor(Color(.windowBackgroundColor)))
                        .frame(height: 4),
                    
                    thumb: Circle()
                        .shadow(radius: 0.25)
                        .foregroundColor(.white),
                    thumbSize: CGSize(width: 12, height: 12)
                )
            )
            .frame(width: width)
            
            Text("\(value)%")
                .font(.system(size: systemFontSize))
                .foregroundColor(isEnabled ? Color(.controlTextColor) : Color(.disabledControlTextColor))
                .padding(6)
                .frame(width: 50)
                .background(Color(NSColor.windowBackgroundColor))
                .clipShape(RoundedRectangle(cornerRadius: 6))
            
            Spacer()
        }
    }
}






// MARK:- SwiftUI_Previews
struct MySliderView_Previews: PreviewProvider {
    static var previews: some View {
        SliderView(text: "Description", value: .constant(25), isEnabled: true)
    }
}
