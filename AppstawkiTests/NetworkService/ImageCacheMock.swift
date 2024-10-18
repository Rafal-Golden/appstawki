//
//  ImageCacheMock.swift
//  Appstawki
//
//  Created by Rafal Korzynski on 16/10/2024.
//

import UIKit
@testable import Appstawki


class ImageCacheMock: ImageCacheProtocol {
    func getImage(forKey key: String) -> UIImage? {
        return nil
    }
    
    func setImage(_ image: UIImage, forKey key: String) {}
}
