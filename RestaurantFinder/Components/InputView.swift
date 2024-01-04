//
//  InputView.swift
//  RestaurantFinder
//
//  Created by Vihaan Deepak Phal on 11/2/23.
//

import SwiftUI

struct InputView: View {
    @Binding var text: String
    let title: String
    let placeholder: String
    var isSecureField: Bool
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text(title)
                .foregroundColor(.white)
                .fontWeight(.bold)
                .font(.headline)
            
            
            if isSecureField {
                SecureField(placeholder, text: $text)
                    .font(.body)
                    .padding(12)
                    .background(Color.white.opacity(0.1))
                    .cornerRadius(8)
                    .shadow(color: .gray.opacity(0.5), radius: 2, x: 0, y: 2)
                    .foregroundColor(.white)
            } else {
                TextField(placeholder, text: $text)
                    .font(.body)
                    .padding(12)
                    .background(Color.white.opacity(0.1))
                    .cornerRadius(8)
                    .shadow(color: .gray.opacity(0.5), radius: 2, x: 0, y: 2)
                    .foregroundColor(.white)
            }
            Divider().background(Color.white)
        }
        .padding(.horizontal)
    }
}

struct InputView_Previews: PreviewProvider {
    static var previews: some View {
        InputView(text: .constant(""), title: "Email Address", placeholder: "name@gmail.com", isSecureField: false)
    }
}
