//
//  ImageViewModel.swift
//  RedditReader
//
//  Created by Alfonso Mestre on 29/5/21.
//

import Foundation

final class ImageViewModel: ObservableObject {
    
    private let serviceManager : RedditListingServiceManager
    
    private let urlString: String

    @Published var data: Data?
    
    init(_ manager: RedditListingServiceManager = RedditListingServiceManager(), urlString: String) {
        self.serviceManager = manager
        self.urlString = urlString
    }
    
    func loadImage() {
        self.serviceManager.getImage(imageUrl: self.urlString) { result in
            switch result {
            case .success(let data):
                self.data = data
            case .failure(_):
                self.data = nil
            }
        }
    }
}
