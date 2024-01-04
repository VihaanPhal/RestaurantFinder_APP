//
//  LoginView.swift
//  RestaurantFinder
//
//  Created by Vihaan Deepak Phal on 11/2/23.
//

import SwiftUI

struct LoginView: View {
    @State var email = ""
    @State var password = ""
    @EnvironmentObject var  viewModel: AuthViewModel
    
    var body: some View {
        NavigationStack{
            ZStack{
                Image("loginimage")
                    .resizable()
                    .scaledToFill()
                    .frame(width: 450, height: 00)
                
                VStack{
                    Text("Login IN")
                        .font(.custom("Chalkduster", size: 37))
                        .fontWeight(.semibold)
                        .font(.title) 
                        .foregroundColor(.white)
                        .padding(.top,33)
                        .opacity(0.9)
           
                    Spacer()
                    
                    
                    InputView(text: $email, title: "Email Address", placeholder: "name@gmail.com", isSecureField: false)
                        .autocorrectionDisabled()
                        .autocapitalization(.none)
                        .padding()
                    
                    InputView(text: $password, title: "Password", placeholder: "Enter your Password",isSecureField: true)
                        .autocorrectionDisabled()
                        .autocapitalization(.none)
                        .padding()
                    
                    
                   
                    Button(action: {
                        
                        Task {
                            try await viewModel.signIn(withEmail: email, password: password)
                        }
                    }) {
                        HStack {
                            Text("SIGN IN")
                                .fontWeight(.semibold)
                                .font(.title)
                                .foregroundColor(.black)
                            Image(systemName: "arrow.right")
                                .foregroundColor(.black)
                        }
                        .frame(width: UIScreen.main.bounds.width - 64, height: 60)
                        .background(Color.white)
                        .cornerRadius(15)
                        .shadow(color: .gray, radius: 2, x: 0, y: 4)
                        .overlay(
                            RoundedRectangle(cornerRadius: 15)
                                .stroke(Color.gray, lineWidth: 0.5)
                        )
                        .disabled(!formIsValid)
                        .opacity(formIsValid ? 1 : 0.5)
                        .padding(.top, 24)
                    }

                    
                    
                    Spacer()
                    //signup button
                    NavigationLink{
                        SignupView()
                            .navigationBarBackButtonHidden()
                    }label: {
                        HStack(spacing: 3){
                            Text("Don't have and account?")
                            Text("Sign up").fontWeight(.bold)
                                .foregroundColor(Color.yellow)
                            
                        }
                        .font(.system(size: 14))
                        .foregroundColor(Color.white)
        
                    }
                    
                }.padding()
            }
        }
    }
}

extension LoginView: AuthenticationFormProtocol {
    var formIsValid: Bool {
        return !email.isEmpty
        && email.contains("@")
        && !password.isEmpty
        && password.count > 5
    }
}


struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
