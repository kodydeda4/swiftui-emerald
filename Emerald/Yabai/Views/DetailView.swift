import SwiftUI

struct DetailView: View {
  let config: Config
  
  var body: some View {
    ScrollView {
      Text(config.output)
        .font(.system(.body, design: .monospaced))
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
        .padding()
    }
  }
}

struct DetailView_Previews: PreviewProvider {
  static var previews: some View {
    DetailView(config: Config())
  }
}
