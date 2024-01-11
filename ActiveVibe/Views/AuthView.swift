//
//  AuthView.swift
//  ActiveVibe
//
//  Created by Vaibhav  Tiwary on 11/01/24.
//

import SwiftUI

struct AuthView: View {
    
    @State private var CurrentViewShowing:String = "login"
    var body: some View {
        if (CurrentViewShowing=="login"){
            LoginView(CurrentShowingView:$CurrentViewShowing ).preferredColorScheme(.light)
        }
        else{
            SignupView(CurrentShowingView:$CurrentViewShowing).preferredColorScheme(/*@START_MENU_TOKEN@*/.dark/*@END_MENU_TOKEN@*/)
                .transition(.move(edge: .top))
        }
    }
}

#Preview {
    AuthView()
}
