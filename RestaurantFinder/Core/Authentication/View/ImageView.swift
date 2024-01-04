//
//  ImageView.swift
//  RestaurantFinder
//
//  Created by Vihaan Deepak Phal on 11/19/23.
//

import SwiftUI


struct ImageView: View {
    @ObservedObject private var viewModel: ImageViewModel
    
    init(urlString: String?) {
        viewModel = ImageViewModel(urlString: urlString)
    }
    
    var body: some View {
        Image (uiImage: viewModel.image ?? UIImage())
            .resizable()
            .frame(width: 90, height: 80)
    }
}
        
        
struct ImageView_Previews: PreviewProvider {
        static var previews: some View {
            ImageView(urlString: "https://developer.apple.com/news/images/og/swiftui-og.png")
    }
}
    


