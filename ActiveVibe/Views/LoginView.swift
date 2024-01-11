//
//  LoginView.swift
//  ActiveVibe
//
//  Created by Vaibhav  Tiwary on 09/01/24.
//

import SwiftUI

struct LoginView: View {
    @Binding var CurrentShowingView:String
    @State private var email:String=""
    @State private var password:String=""
    private func validPassword(_password:String) -> Bool{
        let passwordRegex = NSPredicate(format: "SELF MATCHES %@", "^(?=.*[a-z])(?=.*[$@$#!%*?&])(?=.*[A-Z]).{6,}$")
        
        return passwordRegex.evaluate(with: password)}
    var body: some View {
        
        ZStack {
            VStack
            {
                Image("Login")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 500, height: 350)
                    .offset(y:-110)
                
                HStack{
                    Text("Welcome")
                        .font(.largeTitle)
                        .bold()
                        .offset(y:-175)
                    Spacer()
                }
                
                VStack{
                   HStack{
                    Image(systemName: "mail")
                    TextField("Email",text:$email)
                       if (email.count != 0){
                           
                           Image(systemName: email.isValidEmail() ? "checkmark":"xmark")
                               .fontWeight(.bold)
                               .foregroundColor(email.isValidEmail() ? .green:.red)
                       }
                }
                .padding()
                .overlay{
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(lineWidth: 3)
                        .foregroundColor(.black)
                    
                }
                .padding()
                
                HStack{
                    Image(systemName: "lock")
                    SecureField("Password",text:$password)
                    
                    if(password.count != 0){
                        Image(systemName:validPassword(_password:password) ? "checkmark":"xmark")
                            .fontWeight(.bold)
                            .foregroundColor(validPassword(_password:password) ? .green:.red)
                    }
                }
                .padding()
                .overlay{
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(lineWidth: 3)
                        .foregroundColor(.black)
                    
                }
                .padding()
                
                    Button(action: {
                        withAnimation {
                            self.CurrentShowingView="signup"
                        }
                        
                    }, label: {
                    Text("Don't have an account?")
                        .foregroundColor(.blue.opacity(0.8))
                    
                })
                   
               }
               .offset(y:-150)
                Spacer()
                
                Spacer()
                Button{} 
                    label: {
                            Text("Sign In")
                            .foregroundColor(.white)
                            .font(.title3)
                            .bold()
                            .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/)
                            .padding()
                            .background(
                            RoundedRectangle(cornerRadius: 10)
                                .fill(Color.blue)
                            )
                            .padding(.horizontal)
                        
                    
                    }
                    
                    
                
                
                
                
               
                
            }
            
            
            
            
            
        }
            
        .padding()
    }
}
   

