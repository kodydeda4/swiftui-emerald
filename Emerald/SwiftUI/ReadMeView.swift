import SwiftUI

private var readme: String {
  """
  - Requires that you already have Yabai installed.
  """
}

struct ReadMeView: View {
  @Binding var isPresented: Bool
  
  var body: some View {
    VStack(alignment: .leading, spacing: 20) {
      Button("Close", toggle: $isPresented)
        .frame(maxWidth: .infinity, alignment: .trailing)
      
      Text("Readme")
        .font(.title)
        .bold()
      
      Text(readme)
    }
    .frame(width: 600, height: 600, alignment: .topLeading)
    .padding()
  }
}

struct ReadMeView_Previews: PreviewProvider {
  static var previews: some View {
    ReadMeView(
      isPresented: .constant(true)
    )
  }
}
