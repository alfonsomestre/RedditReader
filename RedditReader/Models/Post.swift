//
//  Post.swift
//  RedditReader
//
//  Created by Alfonso Mestre on 29/5/21.
//

import Foundation

struct Post: Decodable, Equatable {
    let title: String
    let id: String
    let thumbnail: String
    let url: String
    let author: String
    let subreddit: String
    let score: Int
    let num_comments: Int
    let created_utc: Double
    let post_hint: String?
    
    static func == (lhs: Post, rhs: Post) -> Bool {
        return lhs.id == rhs.id
    }
}
