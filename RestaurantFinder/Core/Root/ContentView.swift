//
//  ContentView.swift
//  RestaurantFinder
//
//  Created by Vihaan Deepak Phal on 11/2/23.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var viewModel: AuthViewModel
    var body: some View {
        Group{
           
                LoginView();
            
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
