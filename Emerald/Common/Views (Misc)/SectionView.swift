//
//  SectionView.swift
//  Emerald
//
//  Created by Kody Deda on 2/24/21.
//

import SwiftUI

struct SectionView<Content: View>: View {
    let title: String
    let content: Content
    
    init(_ title: String,
         @ViewBuilder content: () -> Content
    ) {
        self.title = title
        self.content = content()
    }
    
    var body: some View {
//        GroupBox {
            VStack(alignment: .leading) {
                    Text(title)
                        .font(.title)
                        .bold()
                    Divider()
                    content
            }
            .padding()
//        }
//        .padding()
    }
}

struct SectionView_Previews: PreviewProvider {
    static var previews: some View {
        SectionView("Title") {
            Picker("View A", selection: .constant("Breakfast")) {
                ForEach(["Breakfast", "Lunch", "Dinner"], id: \.self) {
                    Text($0)
                }
            }
            HStack {
                Text("View B")
                TextField("", text: .constant("25"))
            }
        }
    }
}
