//
//  RedditListingTestService.swift
//  RedditReader
//
//  Created by Alfonso Mestre on 30/5/21.
//

import Foundation

final class RedditListingTestService: RedditListingServiceProtocol {

    let error: NetworkingError?
    
    init(_ error: NetworkingError? = nil) {
        self.error = error
    }
    
    func getReddits(topic: Topic, after: String?, count: Int, completion: @escaping (Result<Listing, NetworkingError>) -> Void) {
        let post1 = Post(title: "Before and after of the excavation of the Ancient Greek Stadium", id: "nn67r2", thumbnail: "https://b.thumbs.redditmedia.com/CmDB854t-TWxbrlQxPgwkiAQ9bkLvrZty-mtppYTNPM.jpg", url: "https://i.redd.it/9e5v2ymql9271.png", author: "WillOfTheLand", subreddit: "interestingasfuck", score: 105023, num_comments: 4930, created_utc: 1622383572.0, post_hint: "image")
        
        let post2 = Post(title: "Before and after of the excavation of the Ancient Greek Stadium", id: "nn67r2", thumbnail: "https://b.thumbs.redditmedia.com/wvgbkokOnwfx0aobT_3z06vjawupzkARttjgtGpdXPU.jpg", url: "https://i.redd.it/fxb0wimcaw171.png", author: "lrlOurPresident", subreddit: "interestingasfuck", score: 125332, num_comments: 2221, created_utc: 1622226514.0, post_hint: "image")
        
        let listing = Listing(data: Listing.ListingData(children: [Listing.ListingData.PostData.init(data: post1), Listing.ListingData.PostData.init(data: post2)], after: "after"))
        
        completion(.success(listing))
    }
    
    func getImage(imageUrl: String, completion: @escaping (Result<Data, NetworkingError>) -> Void) {
        if let error = self.error {
            completion(.failure(error))
        } else {
            completion(.success(Data(capacity: 1)))
        }
    }
    
}
