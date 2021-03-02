//
//  SpecialTextView.swift
//  Emerald
//
//  Created by Kody Deda on 2/24/21.
//

import SwiftUI

// TODO: Merge into one.

// MARK:- SpecialTextField
struct SpecialTextField: View {
    let title: String
    @Binding var value: Int
    var disabled: Bool
    let formatter: Formatter = NumberFormatter()
    
    var body: some View {
        HStack {
            Text(title)
            TextField("", value: $value, formatter: formatter)
                .disabled(disabled)
        }
    }
}

struct SpecialTextField_Previews: PreviewProvider {
    static var previews: some View {
        SpecialTextField(title: "Value", value: .constant(64), disabled: false)
    }
}

// MARK:- SpecialTextFieldStrings
struct SpecialTextFieldStrings: View {
    let title: String
    @Binding var value: String
    
    var body: some View {
        HStack {
            Text(title)
            TextField("", text: $value)
        }
    }
}

struct SpecialTextFieldStrings_Previews: PreviewProvider {
    static var previews: some View {
        SpecialTextFieldStrings(title: "Value", value: .constant("Hello"))
    }
}
// MARK:- SpecialTextFieldFloats
struct SpecialTextFieldFloats: View {
    let title: String
    @Binding var value: Float
    var disabled: Bool
    let formatter: Formatter = NumberFormatter()
    
    var body: some View {
        HStack {
            Text(title)
            TextField("", value: $value, formatter: formatter)
                .disabled(disabled)
        }
    }
}

struct SpecialTextFieldFloats_Previews: PreviewProvider {
    static var previews: some View {
        SpecialTextFieldFloats(title: "Value", value: .constant(64.0), disabled: false)
    }
}
