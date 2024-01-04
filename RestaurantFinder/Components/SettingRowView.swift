//
//  SettingRowView.swift
//  RestaurantFinder
//
//  Created by Vihaan Deepak Phal on 11/2/23.
//

import SwiftUI

struct SettingRowView: View {
    let Imagename: String
    let title: String
    let tintColor: Color
    var body: some View {
        HStack(spacing: 12){
            Image(systemName: Imagename)
                .imageScale(.small)
                .font(.title)
                .foregroundColor(tintColor)
            
            Text(title)
                .font(.subheadline)
                .foregroundColor(.black)
            
        }
    }
}

struct SettingRowView_Previews: PreviewProvider {
    static var previews: some View {
        SettingRowView(Imagename: "gear", title: "Version", tintColor: Color(.systemGray))
    }
}
