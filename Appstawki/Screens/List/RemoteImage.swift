//
//  RemoteImage.swift
//  Appstawki
//
//  Created by Rafal Korzynski on 05/10/2024.
//

import SwiftUI

final class ImageLoader: ObservableObject {
    
    let service = NetworkService()
    
    @Published var image: Image? = nil
    
    func load(url: URL) {
        service.downloadImage(url: url) { [weak self] uiImage in
            if let uiImage {
                self?.image = Image(uiImage: uiImage)
            }
        }
    }
}

struct RemoteImage: View {
    
    var image: Image?
    
    var body: some View {
        image?.resizable() ?? Image(systemName: "camera.badge.clock").resizable()
    }
}

struct AppRemoteImage: View {
    
    @StateObject var imageLoader = ImageLoader()
    var url: URL
    
    var body: some View {
        RemoteImage(image: imageLoader.image)
            .onAppear {
                imageLoader.load(url: url)
            }
    }
}

#Preview {
    RemoteImage()
}
