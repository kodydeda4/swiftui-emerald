//
//  SpaceSettingsView.swift
//  Emerald
//
//  Created by Kody Deda on 3/5/21.
//

import SwiftUI
import ComposableArchitecture

struct SpaceSettingsView: View {
    let store: Store<Yabai.State, Yabai.Action>
    let k = Yabai.Action.keyPath
    
    var body: some View {
        WithViewStore(store) { vs in
            ScrollView {
                SectionView("Layout") {
                    Picker("", selection: vs.binding(\.layout, k)) {
                        ForEach(Yabai.State.Layout.allCases) {
                            Text($0.labelDescription.lowercased())
                        }
                    }
                    .labelsHidden()
                    .pickerStyle(SegmentedPickerStyle())
                    .frame(width: 200)
                    
                    Text(vs.layout.caseDescription)
                        .foregroundColor(Color(.gray))
                }
                SectionView("Padding") {
                    HStack {
                        StepperView("Top",    vs.binding(\.paddingTop, k))
                        StepperView("Bottom", vs.binding(\.paddingBottom, k))
                        StepperView("Left",   vs.binding(\.paddingLeft, k))
                        StepperView("Right",  vs.binding(\.paddingRight, k))
                        StepperView("Gaps",   vs.binding(\.windowGap, k))
                    }
                }
                .disabled(vs.layout == .float)
                .opacity( vs.layout == .float ? 0.5 : 1.0)
                
                SectionView("Layout") {
                    KBShortcut(for: .toggleFloating)
                    KBShortcut(for: .toggleBSP)
                    KBShortcut(for: .toggleStacking)
                }
                SectionView("Toggles") {
                    KBShortcut(for: .restartYabai)
                    KBShortcut(for: .togglePadding)
                    KBShortcut(for: .toggleGaps)
                    KBShortcut(for: .toggleSplit)
                    KBShortcut(for: .toggleBalance)
                }
                SectionView("Focus") {
                    KBShortcut(for: .focusNorth)
                    KBShortcut(for: .focusSouth)
                    KBShortcut(for: .focusEast)
                    KBShortcut(for: .focusWest)
                }
                SectionView("Resize") {
                    KBShortcut(for: .resizeTop)
                    KBShortcut(for: .resizeBottom)
                    KBShortcut(for: .resizeRight)
                    KBShortcut(for: .resizeLeft)
                }
                SectionView("Move") {
                    KBShortcut(for: .moveNorth)
                    KBShortcut(for: .moveSouth)
                    KBShortcut(for: .moveEast)
                    KBShortcut(for: .moveWest)
                }
                VStack(alignment: .leading) {
                    Divider()
                    HStack {
                        Group {
                            Toggle("", isOn: vs.binding(\.windowTopmost, k))
                                .labelsHidden()
                            
                            Text("Float-On-Top")
                                .bold().font(.title3)
                        }
                        .disabled(vs.sipEnabled || vs.layout == .float)
                        .opacity( vs.sipEnabled || vs.layout == .float ? 0.5 : 1.0)
                        
                        Spacer()
                        SIPButton(store: Root.defaultStore)
                    }
                    
                    Text("Force floating windows to stay ontop of tiled/stacked windows")
                        .foregroundColor(Color(.gray))
                        .disabled(vs.sipEnabled || vs.layout == .float)
                        .opacity( vs.sipEnabled || vs.layout == .float ? 0.5 : 1.0)
                }
                .padding()
            }
            .navigationTitle("Space")
        }
    }
}

// MARK:- SwiftUI_Previews
struct SpaceSettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SpaceSettingsView(store: Yabai.defaultStore)
    }
}


