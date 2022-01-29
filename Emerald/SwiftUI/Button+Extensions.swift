import SwiftUI

extension Button where Label == Text {
  /// Creates a button that generates its label from a localized string key and toggles a boolean value.
  init(
    _ titleKey: LocalizedStringKey,
    toggle: Binding<Bool>
  ) {
    self.init(
      titleKey,
      action: { toggle.wrappedValue.toggle() }
    )
  }
}

extension Button where Label: View {
  /// Creates a button that generates its label from a localized string key and toggles a boolean value.
  init(
    toggle: Binding<Bool>,
    @ViewBuilder label: @escaping () -> Label
  ) {
    self.init(
      action: { toggle.wrappedValue.toggle() },
      label: label
    )
  }
}

// MARK: Example
private struct Button_Extensions: View {
  @State var a = false
  @State var b = false
  
  var body: some View {
    VStack {
      Button("Close", toggle: $a)
      
      Button(toggle: $b) {
        HStack {
          Image(systemName: "gear")
          Text("Close")
        }
        .padding(12)
        .foregroundColor(.white)
        .background(Color.red)
        .clipShape(RoundedRectangle(cornerRadius: 6, style: .continuous))
      }
      .buttonStyle(.plain)
    }
  }
}

struct Button_Extensions_Previews: PreviewProvider {
  static var previews: some View {
    Button_Extensions()
  }
}
