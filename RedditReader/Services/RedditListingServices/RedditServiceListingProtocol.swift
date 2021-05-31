//
//  RedditServiceListingProtocol.swift
//  RedditReader
//
//  Created by Alfonso Mestre on 30/5/21.
//

import Foundation

protocol RedditListingServiceProtocol {
    func getReddits(topic: Topic, after: String?, count: Int, completion: @escaping(Result<Listing, NetworkingError>) -> Void)
    func getImage(imageUrl: String, completion: @escaping(Result<Data, NetworkingError>) -> Void)
}
