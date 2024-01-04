//
//  SignupView.swift
//  RestaurantFinder
//
//  Created by Vihaan Deepak Phal on 11/2/23.
//

import SwiftUI

struct SignupView: View {
    @State private var email = ""
    @State private var fullname = ""
    @State private var password = ""
    @State private var confirmPassword = ""
    @EnvironmentObject var viewModel: AuthViewModel
    
    @Environment (\.dismiss) var dismiss
    
    var body: some View {
        ZStack{
            Image("loginimage")
                .resizable()
                .scaledToFill()
                .frame(width: 450, height: 00)
            VStack{
                Text("Sign Up")
                    .font(.custom("Chalkduster", size: 39))
                    .fontWeight(.semibold)
                    .font(.title) // Larger font size for emphasis
                    .foregroundColor(.white)
                    .padding(.top,47)
                    .opacity(0.9)
                Spacer()
                Spacer()
    
                VStack(spacing: 24){
                    
                    InputView(text: $email, title: "Email Address", placeholder: "name@gmail.com", isSecureField: false)
                        .autocorrectionDisabled()
                        .autocapitalization(.none)
                        .padding(.horizontal)
                    InputView(text: $fullname, title: "Full Name", placeholder: "Enter your full name", isSecureField: false)
                        .autocorrectionDisabled()
                        .autocapitalization(.none)
                        .padding(.horizontal)
                    
                    InputView(text: $password, title: "Password", placeholder: "Enter your Password",isSecureField: true)
                        .autocorrectionDisabled()
                        .autocapitalization(.none)
                        .padding(.horizontal)
                    
                    ZStack(alignment: .trailing){
                        InputView(text: $confirmPassword, title: "Confirm Password", placeholder: "Confirm your Password",isSecureField: true)
                            .autocorrectionDisabled()
                            .autocapitalization(.none)
                            .padding(.horizontal)
                        if !password.isEmpty && !confirmPassword.isEmpty {
                            if password == confirmPassword {
                                Image(systemName: "checkmark.circle.fill")
                                    .imageScale(.large)
                                    .fontWeight(.bold)
                                    .foregroundColor(Color(.systemGreen))
                            }else{
                                Image(systemName: "xmark.circle.fill")
                                    .imageScale(.large)
                                    .fontWeight(.bold)
                                    .foregroundColor(Color(.systemRed))
                                
                            }
                        }
                    }
                    
                }
                .padding(.horizontal)
                .padding(.top,20)
                
                
                Button{
                    Task{
                        try await viewModel.createUser(withEmail: email,
                                                       password: password,
                                                       fullname: fullname)
                    }
                }label: {
                    HStack{
                        Text("SIGN UP")
                            .fontWeight(.semibold)
                            .font(.title) // Larger font size for emphasis
                            .foregroundColor(.black)
                        Image(systemName: "arrow.right")
                            .foregroundColor(.black)
                    }
                    .foregroundColor(.white)
                    .frame(width: UIScreen.main.bounds.width - 32,height: 48)
                }
                .frame(width: UIScreen.main.bounds.width - 64, height: 60) // Increase button height for prominence
                .background(Color.white)
                .cornerRadius(15)
                .shadow(color: .gray, radius: 2, x: 0, y: 4)
                .overlay(
                    RoundedRectangle(cornerRadius: 15)
                        .stroke(Color.gray, lineWidth: 0.5) // Border to enhance the button
                )
                .padding([.top, .leading, .trailing])
                
                
                
                
                Spacer()
               
                
                Button{
                    dismiss()
                }label: {
                    HStack(spacing: 3){
                        Text("Already have and account?")
                        Text("Sign in").fontWeight(.bold)
                            .foregroundColor(Color.yellow)
                        
                    }
                    .font(.system(size: 17))
                    .foregroundColor(Color.white)
                    
                }
                Spacer()
            }
        }
    }
}

extension SignupView: AuthenticationFormProtocol {
    var formIsValid: Bool {
        return !email.isEmpty
        && email.contains("@")
        && !password.isEmpty
        && password.count > 5
        && confirmPassword == password
        && !fullname.isEmpty
        
    }
}

struct SignupView_Previews: PreviewProvider {
    static var previews: some View {
        SignupView()
    }
}
