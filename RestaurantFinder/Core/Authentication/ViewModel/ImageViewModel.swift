//
//  ImageViewModel.swift
//  RestaurantFinder
//
//  Created by Vihaan Deepak Phal on 11/19/23.
//

import Foundation

import SwiftUI
class ImageViewModel: ObservableObject {
    @Published var image: UIImage?
    
    private var imageCache: NSCache<NSString, UIImage>?
    init(urlString: String?) {
        loadImage(urlString: urlString)
    }
    private func loadImage (urlString: String?) {
        guard let urlString = urlString else { return }
        // load image from cache
        if let imageFromCache = getImageCache(from: urlString) {
            image = imageFromCache
            return
        }
        // load image from url
        loadImageFromUr1(urlString: urlString)
    }
    // load image from url
    private func loadImageFromUr1(urlString: String) {
        guard let url = URL(string: urlString) else { return }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard error == nil else {
                print (error ?? "unkonwn error")
                return
            }
            guard let data = data else {
                print ("No data")
                return
            }
            DispatchQueue.main.sync{[weak self] in
                guard let loadedImage = UIImage(data: data) else { return }
                self?.image = loadedImage
                self?.setImageCache(image: loadedImage, key: urlString)
                
            }
        }.resume() 
    }
    
    private func setImageCache (image: UIImage, key: String) {
        imageCache?.setObject (image, forKey: key as NSString)
    }
    private func getImageCache(from key: String) -> UIImage? {
        return imageCache? .object(forKey: key as NSString) as? UIImage
    }
}
