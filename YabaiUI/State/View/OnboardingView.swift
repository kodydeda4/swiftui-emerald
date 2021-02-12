//
//  OnboardingView.swift
//  YabaiUI
//
//  Created by Kody Deda on 2/12/21.
//

import SwiftUI
import ComposableArchitecture

// MARK:- OnboardingView

struct OnboardingView: View {
    let store: Store<Onboarding.State, Onboarding.Action>
    
    var body: some View {
        WithViewStore(store) { viewStore in
            VStack {
                VStack {
                    Image("yabaiLogo")
                        .resizable()
                        .frame(width: 75, height: 75)
                    
                    Text("Welcome to YabaiUI")
                        .font(.largeTitle)
                        .fontWeight(.medium)
                    
                    Text("Some super neat description.")
                        .font(.body)
                        .foregroundColor(.gray)
                }
                
                VStack {
                    FeatureView(
                        image: Image(systemName: "sparkles"),
                        featureName: "Feature A",
                        featureDescription: "Description about how cool said feature is."
                    )
                    FeatureView(
                        image: Image(systemName: "scribble.variable"),
                        featureName: "Feature B",
                        featureDescription: "Description about how cool said feature is."
                    )
                    FeatureView(
                        image: Image(systemName: "leaf.fill"),
                        featureName: "Feature C",
                        featureDescription: "Description about how cool said feature is."
                    )
                }
                .padding()
                
                Spacer()
                Button("Continue") { viewStore.send(.toggleDismissed) }
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
    let image: Image
    let featureName: String
    let featureDescription: String
    
    var body: some View {
        HStack {
            image
                .resizable()
                .frame(width: 24, height: 24)
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
            image: Image(systemName: "sparkles"),
            featureName: "Feature",
            featureDescription: "Description"
        )
    }
}

struct OnboardingView_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingView(store: Onboarding.defaultStore)
    }
}



