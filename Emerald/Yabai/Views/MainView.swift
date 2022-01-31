import SwiftUI

struct MainView: View {
  @Binding var config: Config
  
  var body: some View {
    List {
      SectionView("Space") {
        SpaceSettingsView(config: $config)
      }
      SectionView("Window") {
        WindowSettingsView(config: $config)
      }
      SectionView("Mouse") {
        MouseSettingsView(config: $config)
      }
      SectionView("External Bar") {
        ExternalBarSettingsView(config: $config)
      }
    }
  }
}

struct SectionView<Content>: View where Content: View {
  let title: String
  let content: () -> Content
  
  init(
    _ title: String,
    @ViewBuilder content: @escaping () -> Content
  ) {
    self.title = title
    self.content = content
  }
  var body: some View {
    Section(title) {
      //      GroupBox {
      //        Section(title) {
      content()
      //      }
    }
  }
}




struct MainView_Previews: PreviewProvider {
  static var previews: some View {
    MainView(config: .constant(Config()))
  }
}
