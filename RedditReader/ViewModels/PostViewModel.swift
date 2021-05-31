//
//  PostViewModel.swift
//  RedditReader
//
//  Created by Alfonso Mestre on 29/5/21.
//

import Foundation

enum SupportedPostDetail: String, CaseIterable {
    case image = "image"
}

final class PostViewModel: Identifiable, Equatable {
    
    private let post: Post
    
    init(post: Post) {
        self.post = post
    }
    
    var id: String {
        self.post.id
    }
    
    func getImageURL() -> URL? {
        if let url = URL(string: self.post.thumbnail) {
            return url
        }
        return nil
    }
    
    func getTimeSince() -> String {
        let formatter = RelativeDateTimeFormatter()
        return formatter.localizedString(for: Date(timeIntervalSince1970: self.post.created_utc), relativeTo: Date())
    }
    
    func getCommentsKmValue() -> String {
        return self.post.num_comments.kmValue
    }
    
    func getScoreKmValue() -> String {
        return self.post.score.kmValue
    }
    
    func getSubrredit() -> String {
        return "r/\(self.post.subreddit)"
    }
    
    func getTitle() -> String {
        return self.post.title
    }
    
    func getThumbnail() -> String {
        return self.post.thumbnail
    }
    
    func hasDetail() -> Bool {
        if let post_hint = self.post.post_hint, let _ = SupportedPostDetail(rawValue: post_hint), !self.post.url.isEmpty {
            return true
        }
        return false
    }
    
    func getPost() -> Post {
        return self.post
    }
    
    static func == (lhs: PostViewModel, rhs: PostViewModel) -> Bool {
        return lhs.post == rhs.post
    }
}
