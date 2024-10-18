//
//  ImageCacheProtocol.swift
//  Appstawki
//
//  Created by Rafal Korzynski on 16/10/2024.
//
import UIKit


protocol ImageCacheProtocol {
    func getImage(forKey key: String) -> UIImage?
    func setImage(_ image: UIImage, forKey key: String)
}

class ImageCache: ImageCacheProtocol {
    
    let cache: NSCache<NSString, UIImage>
    
    init(cache: NSCache<NSString, UIImage> = .init()) {
        self.cache = cache
    }
    
    func getImage(forKey key: String) -> UIImage? {
        let cacheKey = NSString(string: key)
        return cache.object(forKey: cacheKey)
    }
    
    func setImage(_ image: UIImage, forKey key: String) {
        let cacheKey = NSString(string: key)
        cache.setObject(image, forKey: cacheKey)
    }
}
