//
//  ContentView.swift
//  ActiveVibe
//
//  Created by Vaibhav  Tiwary on 09/01/24.
//

import SwiftUI
import FirebaseAuth
struct ContentView: View {
    @AppStorage("uid") var userID:String = ""
    var body: some View {
       
        if (userID == ""){
            OnBoarding()
        }
        else{
            HomeView()
            
                
            }
        
        
        
    }
        
}

#Preview {
    ContentView()
}
