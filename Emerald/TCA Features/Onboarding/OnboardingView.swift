//
//  OnboardingView.swift
//  Emerald
//
//  Created by Kody Deda on 2/12/21.
//

import SwiftUI
import ComposableArchitecture

struct OnboardingView: View {
    let store: Store<Onboarding.State, Onboarding.Action>
    
    var body: some View {
        WithViewStore(store) { viewStore in
            VStack {
                VStack {
                    Image("yabaiLogo")
                        .resizable()
                        .frame(width: 75, height: 75)
                    
                    Text("Extra Features")
                        .font(.largeTitle)
                        .fontWeight(.medium)
                    
                    Text("Some features require a connection to the macOS window server, which can only be established by partially disabling System Integrity Protection.")
                        .font(.body)
                        .multilineTextAlignment(.center)
                        .foregroundColor(.gray)
                        .frame(width: 500)
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
                        featureDescription: "Set all floating windows to always-on-top"
                    )
                }
                .padding()
                
                Spacer()
                Button("Continue") { viewStore.send(.toggleIsOnboaring) }
                    .buttonStyle(PlainButtonStyle())
                    .padding(.vertical, 6)
                    .padding(.horizontal, 12)
                    .background(Color.accentColor)
                    .clipShape(RoundedRectangle(cornerRadius: 6))
            }
            .padding()
        }
    }
}

struct WelcomeView: View {
    let store: Store<Onboarding.State, Onboarding.Action>
    
    var body: some View {
        WithViewStore(store) { viewStore in
            VStack {
                VStack {
                    Image("yabaiLogo")
                        .resizable()
                        .frame(width: 75, height: 75)
                    
                    Text("Welcome to Emerald")
                        .font(.largeTitle)
                        .fontWeight(.medium)
                    
                    Text("Some super neat description.")
                        .font(.body)
                        .foregroundColor(.gray)
                }
                VStack {
                    FeatureView(
                        featureName: "Feature A",
                        image: Image(systemName: "sparkles"),
                        featureDescription: "Description about how cool said feature is."
                    )
                    FeatureView(
                        featureName: "Feature B",
                        image: Image(systemName: "scribble.variable"),
                        featureDescription: "Description about how cool said feature is."
                    )
                    FeatureView(
                        featureName: "Feature C",
                        image: Image(systemName: "leaf.fill"),
                        featureDescription: "Description about how cool said feature is."
                    )
                }
                .padding()
                
                Spacer()
                Button("Continue") { viewStore.send(.toggleIsOnboaring) }
                    .buttonStyle(PlainButtonStyle())
                    .padding(.vertical, 6)
                    .padding(.horizontal, 12)
                    .background(Color.accentColor)
                    .clipShape(RoundedRectangle(cornerRadius: 6))
            }
            .padding()
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
                .frame(width: 24, height: 24)
                .scaledToFit()
                .foregroundColor(.accentColor)
            
            VStack(alignment: .leading) {
                Text(featureName)
                    .font(.title3)
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


