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
    
    var isEnabled: Bool
    
    @State var range = 0...10
    
    var body: some View {
        HStack {
            Text(text)
                //.font(.system(size: systemFontSize))
                .foregroundColor(isEnabled ? Color.primary : Color(NSColor.darkGray))
                .lineLimit(1)
                .frame(width: width*0.75)

            ValueSlider(value: $value, in: 0...100, step: 1)
                .disabled(!isEnabled)
                .valueSliderStyle(
                    HorizontalValueSliderStyle(
                        track:
                            HorizontalValueTrack(
                                view: Capsule().foregroundColor(isEnabled ? Color.accentColor : Color(NSColor.darkGray))
                            )
                            .background(Capsule().foregroundColor(Color.gray.opacity(0.25)))
                            .frame(height: 4),
                        
                        thumb: Circle().foregroundColor( isEnabled ? .white : .gray),
                        thumbSize: CGSize(width: 12, height: 12)
                    )
                )
                .frame(width: width)
            
            Text("\(value)%")
                .font(.system(size: systemFontSize))
                .foregroundColor(isEnabled ? Color.primary : Color(NSColor.darkGray))
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
        MySliderView(text: "Description", value: .constant(25), isEnabled: true)
    }
}
