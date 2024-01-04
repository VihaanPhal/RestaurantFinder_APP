import SwiftUI
import MapKit


struct RestaurantLocation: Identifiable {
    let id = UUID()
    var name: String
    var coordinate: CLLocationCoordinate2D
}

struct detailview: View {
    var restaurant: Business
    @State private var region: MKCoordinateRegion
    private var restaurantLocation: RestaurantLocation

    init(restaurant: Business) {
        self.restaurant = restaurant
        let coordinate = CLLocationCoordinate2D(
            latitude: restaurant.coordinates.latitude ?? 0,
            longitude: restaurant.coordinates.longitude ?? 0
        )
        self.restaurantLocation = RestaurantLocation(name: restaurant.name ?? "", coordinate: coordinate)
        self._region = State(initialValue: MKCoordinateRegion(
            center: coordinate,
            span: MKCoordinateSpan(latitudeDelta: 0.005, longitudeDelta: 0.005)
        ))
    }

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 10) {
                HStack{
                    Spacer()
                    ImageView(urlString: restaurant.imageUrl) // Assuming ImageView is your custom view
                    //.aspectRatio(contentMode: .fill)
                    .cornerRadius(10)
                    Spacer()
                    
                }

                Group {
                    Text(restaurant.name ?? "N/A")
                        .font(.subheadline)
                        .fontWeight(.bold)

                    Text("Address: \(restaurant.location.address1 ?? "N/A")")
                    Text("City: \(restaurant.location.city ?? "N/A")")
                    Text("State: \(restaurant.location.state ?? "N/A")")
                    Text("Zip: \(restaurant.location.zipCode ?? "N/A")")
                    Text("Phone: \(restaurant.phone ?? "N/A")")
                }
                .padding(.horizontal)

                // Map view with a pin for the restaurant's location
                Map(coordinateRegion: $region, annotationItems: [restaurantLocation]) { location in
                    MapPin(coordinate: location.coordinate, tint: .red)
                }
                .frame(height: 200)
                .cornerRadius(10)
                .padding()
            }
            .padding()
        }
        .navigationBarTitle("Restaurant Details", displayMode: .inline)
    }
}
