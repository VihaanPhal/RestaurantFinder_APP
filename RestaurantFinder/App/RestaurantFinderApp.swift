//
//  RestaurantFinderApp.swift
//  RestaurantFinder
//
//  Created by Vihaan Deepak Phal on 11/2/23.
//

import SwiftUI
import Firebase

@main
struct RestaurantFinderApp: App {
    @StateObject var viewModel = AuthViewModel()
    
    init() {
        
        FirebaseApp.configure()
    }
    var body: some Scene {
        
        WindowGroup {
            ContentView()
                .environmentObject(viewModel)
        }
    }
}
