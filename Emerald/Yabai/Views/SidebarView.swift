import SwiftUI

struct SidebarView: View {
  @Binding var config: Config
  
  var body: some View {
    VStack {
      List {
        HeaderView()
        
        Section("Settings") {
          NavigationLink(destination: ExternalBarSettingsView(config: $config)) {
            Label("Menu", systemImage: "rectangle.topthird.inset.filled")
          }
          NavigationLink(destination: SpaceSettingsView(config: $config)) {
            Label("Layout", systemImage: "macwindow.on.rectangle")
          }
          NavigationLink(destination: WindowSettingsView(config: $config)) {
            Label("Balance", systemImage: "circle.grid.2x1.left.filled")
          }
          NavigationLink(destination: MouseSettingsView(config: $config)) {
            Label("Mouse", systemImage: "magicmouse.fill")
          }
          
        }
      }
      
      Spacer()
      
      Button(action: { }) {
        HStack {
          Image(systemName: "plus.circle")
          Text("Action")
          Spacer()
        }
      }
      .buttonStyle(.plain)
      .foregroundColor(.gray)
      .padding(8)
    }
    .listStyle(.sidebar)
  }
}

struct HeaderView: View {
  var body: some View {
    HStack {
      Image("logo")
        .resizable()
        .scaledToFit()
        .shadow(radius: 4)
        .padding(2)
        .background(Color.accentColor)
        .clipShape(RoundedRectangle(cornerRadius: 8, style: .continuous))
        .frame(width: 35, height: 35)
      
      VStack(alignment: .leading) {
        Text("Emerald")
        
        Text("Description")
          .font(.caption)
          .opacity(0.75)
      }
      Spacer()
    }
    .padding(4)
  }
}

struct SidebarView_Previews: PreviewProvider {
  static var previews: some View {
    SidebarView(config: .constant(Config()))
  }
}
