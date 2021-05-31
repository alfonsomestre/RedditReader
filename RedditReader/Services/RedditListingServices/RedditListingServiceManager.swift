//
//  RedditListingServiceManager.swift
//  RedditReader
//
//  Created by Alfonso Mestre on 29/5/21.
//

import Foundation

final class RedditListingServiceManager {
    
    private var serviceProvider: RedditListingServiceProtocol
    
    init(serviceProvider: RedditListingServiceProtocol = RedditListingService(NetworkingURLSession())) {
        self.serviceProvider = serviceProvider
    }

    func getReddits(topic: Topic, after: String?, count: Int, completion: @escaping(Result<Listing, NetworkingError>) -> Void) {
        self.serviceProvider.getReddits(topic: topic, after: after, count: count) { (result) in
            completion(result)
        }
    }

    func getImage(imageUrl: String, completion: @escaping(Result<Data, NetworkingError>) -> Void) {
        self.serviceProvider.getImage(imageUrl: imageUrl) { (result) in
            completion(result)
        }
    }
}
