//
//  OnboardingView.swift
//  Emerald
//
//  Created by Kody Deda on 2/12/21.
//

import SwiftUI
import ComposableArchitecture

//  require a connection to the macOS window server, which can only be established by partially disabling System Integrity Protection.")

struct OnboardingView: View {
    let store: Store<Onboarding.State, Onboarding.Action>
    
    let description: String =
    """
    Emerald has some extra features that you might enjoy.
    They're free, but require steps to set-up.
    """
    
    var body: some View {
        WithViewStore(store) { viewStore in
            VStack {
                VStack {
                    Image("Emerald")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 75, height: 75)
                    
                    Text("Extra Features")
                        .font(.title)
                        .fontWeight(.medium)
                    
                    Text(description)
                        .multilineTextAlignment(.center)
                        .foregroundColor(.gray)
                        
                }
                VStack(alignment: .leading) {
                    ForEach(viewStore.features) { feature in
                        HStack {
                            feature.image
                                .resizable()
                                .scaledToFit()
                                .frame(width: 24, height: 24)
                                .foregroundColor(.accentColor)
                            
                            VStack(alignment: .leading) {
                                Text(feature.featureName)
                                    .font(.headline)
                                    .fontWeight(.medium)
                                
                                Text(feature.featureDescription)
                                    .font(.body)
                                    .foregroundColor(.gray)
                            }
                        }
                        .padding(.vertical, 4)
                    }
                }
                .padding()
                
                Toggle("Don't show me this again", isOn: .constant(true))
                    .padding(.bottom)
                
                HStack {
                    Button("No Thanks") { viewStore.send(.toggleIsOnboaring) }
                        .buttonStyle(RoundedRectangleButtonStyle())
                    
                    Button("Continue") { viewStore.send(.toggleIsOnboaring) }
                        .buttonStyle(RoundedRectangleButtonStyle(color: .accentColor))
                }
            }
            .padding(30)
        }
    }
}





struct OnboardingView_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingView(store: Onboarding.defaultStore)
    }
}


