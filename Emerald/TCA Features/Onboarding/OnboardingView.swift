//
//  OnboardingView.swift
//  Emerald
//
//  Created by Kody Deda on 2/12/21.
//

import SwiftUI
import ComposableArchitecture
import DynamicColor

struct OnboardingView: View {
    let store: Store<Onboarding.State, Onboarding.Action>
    
    var body: some View {
        WithViewStore(store) { viewStore in
            VStack {
                VStack {
                    Image("yabaiLogo")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 75, height: 75)
                    
                    Text("Extra Features")
                        .font(.largeTitle)
                        .fontWeight(.medium)
                    
                    Text("Emerald has some extra features that you might enjoy.\nThey're free, but require steps to set-up.")//  require a connection to the macOS window server, which can only be established by partially disabling System Integrity Protection.")
                        .font(.body)
                        .multilineTextAlignment(.center)
                        .foregroundColor(.gray)
                }
                VStack(alignment: .leading) {
                    FeatureView(
                        featureName: "Window Shadows",
                        image: Image(systemName: "rectangle.fill.on.rectangle.fill"),
                        featureDescription: "Toggle shadows on/off"
                    )
                    FeatureView(
                        featureName: "Window Borders",
                        image: Image(systemName: "macwindow"),
                        featureDescription: "Apply colored borders to any app"
                    )
                    FeatureView(
                        featureName: "Window Transparency",
                        image: Image(systemName: "wand.and.stars"),
                        featureDescription: "Set active and inactive transparency"
                    )
                    FeatureView(
                        featureName: "Picture-in-Picture",
                        image: Image(systemName: "play.rectangle.fill"),
                        featureDescription: "Enable pip for all windows"
                    )
                    FeatureView(
                        featureName: "Sticky-Windows",
                        image: Image(systemName: "display.2"),
                        featureDescription: "Create windows that appear in all spaces"
                    )
                    FeatureView(
                        featureName: "Float Ontop",
                        image: Image(systemName: "square.3.stack.3d.top.fill"),
                        featureDescription: "Set floating windows to always-on-top"
                    )
                }
                .padding()
                
                HStack {
                    Button(action: {
                        viewStore.send(.toggleIsOnboaring)
                    }, label: {
                        Text("No Thanks")
//                            .padding(.vertical, 6)
//                            .padding(.horizontal, 24)
                            .shadow(color: Color.gray.opacity(0.5), radius: 0.75, y: 1)
                            .frame(width: 100, height: 28)
                            .background(Color(NSColor.placeholderTextColor))
                            .foregroundColor(Color.white)
                            .cornerRadius(6)
                    })
                    .buttonStyle(PlainButtonStyle())
                    
                    Button(action: {
                        viewStore.send(.toggleIsOnboaring)
                    }, label: {
                        Text("Continue")
                            //.padding(.vertical, 6)
                            //.padding(.horizontal, 24)
                            .shadow(color: Color.gray.opacity(0.5), radius: 0.75, y: 1)
                            .frame(width: 100, height: 28)
                            .background(Color.accentColor)
                            .foregroundColor(Color.white)
                            .cornerRadius(6)
                    })
                    .buttonStyle(PlainButtonStyle())
                }
            }
            .padding(20)
        }
    }
}


private struct FeatureView: View {
    let featureName: String
    let image: Image
    let featureDescription: String
    
    var body: some View {
        HStack {
            image
                .resizable()
                .scaledToFit()
                .frame(width: 24, height: 24)
                .foregroundColor(.accentColor)
            
            VStack(alignment: .leading) {
                Text(featureName)
                    .font(.headline)
                    .fontWeight(.medium)
                
                Text(featureDescription)
                    .font(.body)
                    .foregroundColor(.gray)
            }
        }
    }
}

private struct FeatureView_Previews: PreviewProvider {
    static var previews: some View {
        FeatureView(
            featureName: "Feature",
            image: Image(systemName: "sparkles"),
            featureDescription: "Description"
        )
    }
}

struct OnboardingView_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingView(store: Onboarding.defaultStore)
    }
}


