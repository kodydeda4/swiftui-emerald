import SwiftUI

struct ConfigView: View {
  let config: String
  
  init(_ config: String) {
    self.config = config
  }
  
  var body: some View {
    ScrollView {
      Text(config)
        .foregroundColor(Color.accentColor)
        .font(.system(.body, design: .monospaced))
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
        
        .padding()
      
    }
    .background(Color.black)
    .frame(maxWidth: 450)
    .border(Color.accentColor)
  }
}

struct ConfigView_Previews: PreviewProvider {
  static var previews: some View {
    ConfigView("Hello")
  }
}
