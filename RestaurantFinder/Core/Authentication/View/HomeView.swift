import SwiftUI

struct HomeView: View {
    var body: some View {
        NavigationView() {
            ZStack {
                Image("homeimage")
                    .scaledToFill()

                VStack(spacing: 20) {
                    Spacer()
                    
                    NavigationButton(title: "Profile View", destination: ProfileView())
                    NavigationButton(title: "Restaurant Search", destination: RestaurantListView())
                    
                    Spacer()
                }
            }
            //.navigationBarHidden(true)
        }
    }
}

struct NavigationButton<Destination: View>: View {
    let title: String
    let destination: Destination

    var body: some View {
        NavigationLink(destination: destination) {
            Text(title)
                .font(.custom("Chalkduster", size: 24)) 
                .foregroundColor(.white)
                .frame(width: UIScreen.main.bounds.width - 64, height: 60)
                .background(Color.black.opacity(0.2))
                .cornerRadius(15)
                .overlay(
                    RoundedRectangle(cornerRadius: 15)
                        .stroke(Color.white, lineWidth: 2)
                )
                .shadow(color: .gray, radius: 2, x: 0, y: 4)
                .padding(.horizontal)
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
