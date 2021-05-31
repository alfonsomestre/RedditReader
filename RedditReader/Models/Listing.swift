//
//  Listing.swift
//  RedditReader
//
//  Created by Alfonso Mestre on 29/5/21.
//

import Foundation

struct Listing: Decodable {
    let data: ListingData
    
    struct ListingData: Decodable {
        let children: [PostData]
        let after: String?
        
        struct PostData: Decodable {
            let data: Post
        }
    }
}
