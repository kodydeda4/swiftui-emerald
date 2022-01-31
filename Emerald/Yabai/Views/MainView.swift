import SwiftUI

struct MainView: View {
  var body: some View {
    Text("No Selection")
      .font(.title)
      .foregroundColor(.gray)
      .opacity(0.5)
  }
}

struct MainView_Previews: PreviewProvider {
  static var previews: some View {
    MainView()
  }
}
