

import SwiftUI
import Combine
import CoreLocation

let apiKey = "sGQtJ3X9lsPc49Bv7KR9RPFIRtwPFhb6I3SOdWYOOAAnt3StZXm9VrA-FuOHDHkc-KQlwrWcUSFrflRvo8hA_FRBW0ddZu21EOu9_WyCJdSLARHFmHL_1heAbBNYZXYx"


struct RestaurantListView: View {
    @StateObject private var viewModel = RestaurantListViewModel()
    @State private var lat = ""
    @State private var lon = ""
    @State private var searchText = ""
    @State private var isEditing = false
    @State private var address = ""
    
    
    var body: some View {
        Spacer()

        
            VStack{
                Text("Search your favourite restaurants!!")
                    .font(.headline)
                    .bold()
                Spacer()
                searchField
                

                
                    
                        List(viewModel.restaurants) { restaurant in
                            let rating = restaurant.rating
                            NavigationLink(destination: detailview(restaurant: restaurant)){
                            HStack{
                                Group{
                                    ImageView(urlString: restaurant.imageUrl)
                                    VStack(alignment: .leading) {
                                        Text(restaurant.name ?? "")
                                            .font(.headline)
                                        Text(restaurant.location.address1 ?? "")
                                        Text("Rating \(restaurant.rating ?? 2)")
                                        Spacer()
                                        
                                        
                                    }
                                    .padding(.top)
                                }
                            }
                        }
                    }

                    
                }
                .onAppear {
                    viewModel.getjson(searchText: "indian")
        }
    }
    

    
    var searchField: some View{
        
        VStack {
                
            
            HStack {
                TextField("Search", text: $searchText) { isEditing in
                    self.isEditing = isEditing
                }
                .onSubmit {
                    viewModel.getjson(searchText: searchText)
                }
                .padding(7)
                .padding(.horizontal, 25)
                .background(Color(.systemGray6))
                .cornerRadius(8)
                .overlay(
                    HStack {
                        Image(systemName: "magnifyingglass")
                            .foregroundColor(.gray)
                            .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                            .padding(.leading, 8)
                        
                        
                        if isEditing {
                            Button(action: {
                                self.searchText = ""
                            }) {
                                Image(systemName: "multiply.circle.fill")
                                    .foregroundColor(.gray)
                                    .padding(.trailing, 8)
                            }
                        }
                    }
                )
            }
        }
    }
    
    var searchAddress: some View{
        
        VStack {
                
            
            HStack {
                TextField("Search", text: $address) { isEditing in
                    self.isEditing = isEditing
                }
                .onSubmit {
                    forwardGeocoding(address)
                }
                .padding(7)
                .padding(.horizontal, 25)
                .background(Color(.systemGray6))
                .cornerRadius(8)
                .overlay(
                    HStack {
                        Image(systemName: "magnifyingglass")
                            .foregroundColor(.gray)
                            .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                            .padding(.leading, 8)
                        
                        if isEditing {
                            Button(action: {
                                self.searchText = ""
                            }) {
                                Image(systemName: "multiply.circle.fill")
                                    .foregroundColor(.gray)
                                    .padding(.trailing, 8)
                            }
                        }
                    }
                )
            }
        }
    }
    
    func forwardGeocoding(_ addressStr: String)
        {
            _ = CLGeocoder();
            let addressString = addressStr
            CLGeocoder().geocodeAddressString(addressString, completionHandler:
                                                {(placemarks, error) in
                
                if error != nil {
                    print("Geocode failed: \(error!.localizedDescription)")
                } else if placemarks!.count > 0 {
                    let placemark = placemarks![0]
                    let location = placemark.location
                    let coords = location!.coordinate
                    print(coords.latitude)
                    print(coords.longitude)
                   //lat = String(format: "%.2f", coords.latitude)
                   //lon = String(format: "%.2f", coords.longitude)
                    
                }
            })
        }
}

// ViewModel for handling data fetching and storage
class RestaurantListViewModel: ObservableObject {
    @Published var restaurants = [Business]()
    @State var searchtext = ""

    func getjson(searchText: String) {
        let urlStr = "https://api.yelp.com/v3/businesses/search?term=\(searchText.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? "")&latitude=33.4255&longitude=-111.9400"
        guard let url = URL(string: urlStr) else {
            print("Invalid URL")
            return
        }
        
        var request = URLRequest(url: url)
        request.addValue("Bearer \(apiKey)", forHTTPHeaderField: "Authorization")
        
        URLSession.shared.dataTask(with: request) { [weak self] data, response, error in
            // Check for errors
            if let error = error {
                print("Error fetching data: \(error)")
                return
            }

            // Attempt to decode JSON
            do {
                if let data = data {
                    let decodedResponse = try JSONDecoder().decode(BusinessData.self, from: data)
                    DispatchQueue.main.async {
                        self?.restaurants = decodedResponse.businesses
                    }
                }
            } catch {
                print("Decoding failed: \(error)")
            }
        }.resume()
    }
}

// Define the main structure representing the JSON data
struct BusinessData: Codable {
    let total: Int
    let businesses: [Business]
}

// Define the structure for each business
struct Business: Codable, Identifiable {
    let id: String?
    let rating: Double
    let price: String?
    let phone: String?
    let categories: [Category]
    let reviewCount: Double?
    let name: String?
    let url: String?
    let coordinates: Coordinates
    let imageUrl: String?
    let location: Location

    enum CodingKeys: String, CodingKey {
        case id, rating, price, phone, categories
        case reviewCount = "review_count"
        case name, url, coordinates
        case imageUrl = "image_url"
        case location
    }
}

// Define the structure for categories
struct Category: Codable {
    let alias: String?
    let title: String?
}

// Define the structure for coordinates
struct Coordinates: Codable {
    let latitude: Double?
    let longitude: Double?
}

// Define the structure for location
struct Location: Codable {
    let city: String?
    let country: String?
    let address2: String?
    let address3: String?
    let state: String?
    let address1: String?
    let zipCode: String?

    enum CodingKeys: String, CodingKey {
        case city, country, address2, address3, state, address1
        case zipCode = "zip_code"
    }
}
