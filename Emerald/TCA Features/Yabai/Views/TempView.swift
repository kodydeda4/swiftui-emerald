//
//  TempView.swift
//  Emerald
//
//  Created by Kody Deda on 3/26/21.
//

import SwiftUI

struct TempView: View {
    let angle: Double = 30
    let x: CGFloat = 0
    let y: CGFloat = 90
    let z: CGFloat = -45
    
    var body: some View {
        ZStack {
            Window()
                .animation(.spring())
                .rotation3DEffect(
                    Angle(degrees: angle),
                    axis: (x: x, y: y, z: z)
                )
            
            Window()
                .padding(.bottom, 32)
                .animation(.spring())
                .rotation3DEffect(
                    Angle(degrees: angle),
                    axis: (x: x, y: y, z: z)
                )
            
            Window()
                .padding(.bottom, 64)
                .animation(.spring())
                .rotation3DEffect(
                    Angle(degrees: angle),
                    axis: (x: x, y: y, z: z)
                )
        }
        .padding(50)
    }
}

struct TempView_Previews: PreviewProvider {
    static var previews: some View {
        TempView()
    }
}
