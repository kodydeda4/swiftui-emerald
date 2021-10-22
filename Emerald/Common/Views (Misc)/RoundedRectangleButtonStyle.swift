//
//  RoundedRectangleButtonStyle.swift
//  Emerald
//
//  Created by Kody Deda on 3/3/21.
//

import SwiftUI

struct RoundedRectangleButtonStyle: ButtonStyle {
  var color: Color = Color(NSColor.placeholderTextColor)
  
  func makeBody(configuration: Configuration) -> some View {
    configuration
      .label
      .shadow(color: Color.gray.opacity(0.5), radius: 0.75, y: 1)
      .frame(width: 100, height: 28)
      .background(color)
      .foregroundColor(Color.white)
      .opacity(configuration.isPressed ? 0.7 : 1)
      .cornerRadius(6)
  }
}

struct RoundedRectangleButtonStyle_Previews: PreviewProvider {
  
  static var previews: some View {
    Button("Default") { }
      .buttonStyle(RoundedRectangleButtonStyle())
    
    ForEach([Color.blue, .purple, .pink, .orange, .yellow, .green, .gray], id: \.self) { color in
      Button(color.description) { }
        .buttonStyle(RoundedRectangleButtonStyle(color: color))
      
    }
  }
}
