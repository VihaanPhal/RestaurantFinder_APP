import SwiftUI

struct ratingView: View {
    @Binding var rating: Double
    var label = ""
    var maximumRating = 5
    var offImage: Image?
    var onImage = Image(systemName: "star.fill")
    var halfImage = Image(systemName: "star.leadinghalf.fill") // Image for half-filled star
    var offColor = Color.gray
    var onColor = Color.yellow

    var body: some View {
        HStack {
            if !label.isEmpty {
                Text(label)
            }

            ForEach(1...maximumRating, id: \.self) { number in
                Button(action: {
                    rating = Double(number)
                }) {
                    image(for: number)
                        .foregroundStyle(number > Int(ceil(rating)) ? offColor : onColor)
                }
            }
        }
    }

    func image(for number: Int) -> Image {
        if Double(number) > rating {
            if Double(number) - 0.5 == rating {
                return halfImage
            } else {
                return offImage ?? onImage
            }
        } else {
            return onImage
        }
    }
}

struct ratingView_Previews: PreviewProvider {
    static var previews: some View {
        ratingView(rating: .constant(4.5))
    }
}
