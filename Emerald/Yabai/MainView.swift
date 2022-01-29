import SwiftUI

struct MainView: View {
  @Binding var config: Config
  
  var body: some View {
    Form {
      SectionView("Space") {
        Picker("Layout", selection: $config.layout) {
          ForEach(Layout.allCases) {
            Text($0.rawValue)
          }
        }
        Section("Padding") {
          Stepper("Top \(config.paddingTop)", value: $config.paddingTop)
          Stepper("Bottom \(config.paddingBottom)", value: $config.paddingBottom)
          Stepper("Left \(config.paddingLeft)", value: $config.paddingLeft)
          Stepper("Right \(config.paddingRight)", value: $config.paddingRight)
        }
        Stepper("Window Gap \(config.windowGap)", value: $config.windowGap)
      }
      SectionView("Window") {
        Picker("Window Placement", selection: $config.windowPlacement) {
          ForEach(WindowPlacement.allCases) {
            Text($0.rawValue)
          }
        }
        Toggle("Auto-Balance", isOn: $config.autoBalance)
        Stepper("Split Ratio \(config.windowGap)", value: $config.windowGap)
        
        Picker("Window Balance", selection: $config.windowBalance) {
          ForEach(WindowBalance.allCases) {
            Text($0.rawValue)
          }
        }
      }
      SectionView("Mouse") {
        Toggle("Mouse Follows Focus", isOn: $config.mouseFollowsFocus)
        
        Picker("Focus Follows Mouse", selection: $config.focusFollowsMouse) {
          ForEach(FocusFollowsMouse.allCases) {
            Text($0.rawValue)
          }
        }
        Picker("Modifier Key", selection: $config.mouseModifier) {
          ForEach(MouseModifier.allCases) {
            Text($0.rawValue)
          }
        }
        Picker("Left Click + Modifier", selection: $config.mouseAction1) {
          ForEach(MouseAction.allCases) {
            Text($0.rawValue)
          }
        }
        Picker("Right Click + Modifier", selection: $config.mouseAction2) {
          ForEach(MouseAction.allCases) {
            Text($0.rawValue)
          }
        }
        Picker("Drop Action", selection: $config.mouseDropAction) {
          ForEach(MouseDropAction.allCases) {
            Text($0.rawValue)
          }
        }
      }
      SectionView("External Bar") {
        Picker("External Bar", selection: $config.externalBar) {
          ForEach(ExternalBar.allCases) {
            Text($0.rawValue)
          }
        }
        Stepper("Padding Top \(config.externalBarPaddingTop)", value: $config.externalBarPaddingTop)
        Stepper("Padding Bottom \(config.externalBarPaddingBottom)", value: $config.externalBarPaddingBottom)
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
      GroupBox {
        content()
      }
    }
  }
}


struct MainView_Previews: PreviewProvider {
  static var previews: some View {
    MainView(config: .constant(Config()))
  }
}
