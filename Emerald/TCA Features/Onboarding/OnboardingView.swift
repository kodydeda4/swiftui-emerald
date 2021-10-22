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
        Image("Emerald")
          .resizable()
          .scaledToFit()
          .frame(width: 75, height: 75)
        
        Text("Extra Features")
          .font(.title)
          .fontWeight(.medium)
        
        Text(
          """
                    Emerald has some more features you might enjoy.
                    They're free, but require extra set-up.
                    """
        )
        .multilineTextAlignment(.center)
        .foregroundColor(.gray)
        
        VStack(alignment: .leading) {
          ForEach(viewStore.features) { feature in
            HStack {
              feature.image
                .resizable()
                .scaledToFit()
                .foregroundColor(.accentColor)
                .frame(width: 24, height: 24)
              
              VStack(alignment: .leading) {
                Text(feature.name)
                  .font(.headline)
                  .fontWeight(.medium)
                
                Text(feature.description)
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


