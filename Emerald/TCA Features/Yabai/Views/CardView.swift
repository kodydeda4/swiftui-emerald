//
//  SwiftUIView.swift
//  Emerald
//
//  Created by Kody Deda on 5/11/21.
//

import SwiftUI

struct CardView: View {
    var body: some View {
        VStack(alignment: .leading) {
            Image("foo")
                .resizable()
                .scaledToFit()
                .padding()
                .shadow(color: Color.black.opacity(0.3), radius: 10, x: -5, y: 5)
                .background(Color.blue)
            
            Text("description")
                .font(.caption)
                .foregroundColor(.secondary)
                .padding(.leading)

            Text("Title")
                .bold()
                .foregroundColor(.primary)
                .padding([.leading, .bottom])
        }
        .background(Color(.secondaryLabelColor))
        .clipShape(RoundedRectangle(cornerRadius: 10))
        .frame(height: 225)
        .shadow(radius: 6)
    }
}

struct CardView_Previews: PreviewProvider {
    static var previews: some View {
        CardView()
    }
}
