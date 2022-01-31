import SwiftUI

struct DebugView: View {
  let config: Config
  
  var body: some View {
    ScrollView {
      Text(config.output)
        .font(.system(size: 9, weight: Font.Weight.thin, design: .monospaced))
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
        .padding()
    }
    .background(Color.black)
  }
}

struct DetailView_Previews: PreviewProvider {
  static var previews: some View {
    DebugView(config: Config())
  }
}
