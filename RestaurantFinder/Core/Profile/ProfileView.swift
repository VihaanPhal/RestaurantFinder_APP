//
//  ProfileView.swift
//  RestaurantFinder
//
//  Created by Vihaan Deepak Phal on 11/2/23.
//

import SwiftUI

struct ProfileView: View {
    
    @EnvironmentObject var viewModel: AuthViewModel
    var body: some View {
        if let user = viewModel.currentUser{
            List{
                Section{
                    HStack(spacing: 16) {
                        Text(user.initials)
                            .font(.title)
                            .fontWeight(.semibold)
                            .foregroundColor(.white)
                            .frame(width: 72, height: 72)
                            .background(Color(.systemGray))
                            .clipShape(Circle())
                            .overlay(
                                Circle()
                                    .stroke(Color.white, lineWidth: 2)
                            )

                        VStack(alignment: .leading, spacing: 4) {
                            Text(user.fullname)
                                .font(.headline)
                                .fontWeight(.semibold)
                                .lineLimit(1)
                                .foregroundColor(.primary)

                            Text(user.email)
                                .font(.subheadline)
                                .foregroundColor(.secondary)
                        }
                    }

                }
                
                Section("General"){
                    HStack{
                        SettingRowView(Imagename: "gear", title: "Version", tintColor: .gray)
                        Spacer()
                        Text("1.0.0")
                            .font(.subheadline)
                            .foregroundColor(.gray)
                    }
                    
                }
                Section("Account"){
                    
                    Button{
                        viewModel.signOut()
                      print("Signed out...")
                    }label: {
                        SettingRowView(Imagename: "arrow.left.circle.fill",
                                       title: "Sign Out",
                                       tintColor: .red)
                    }
                    
                    Button{
                      print("Delete Account...")
                    }label: {
                        SettingRowView(Imagename: "xmark.circle.fill",
                                       title: "Delete Account",
                                       tintColor: .red)
                    }
                }
            }
        }
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}
