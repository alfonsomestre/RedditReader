//
//  PostDetailViewModel.swift
//  RedditReader
//
//  Created by Alfonso Mestre on 30/5/21.
//

import Foundation

enum PostDetailViewModelAlertType: Identifiable, Equatable {
    
    var id: String { String(reflecting: self) }
    
    case message(message: String)
    
    static func == (lhs: PostDetailViewModelAlertType, rhs: PostDetailViewModelAlertType) -> Bool {
        return lhs.id == rhs.id
    }
}

final class PostDetailViewModel: ObservableObject {
    private let post: Post
    @Published var alertType: PostDetailViewModelAlertType?
    
    init(post: Post) {
        self.post = post
    }
    
    var imageData: Data?
    
    func shouldShowImage() -> Bool {
        if let _ = URL(string: self.post.thumbnail) {
            return true
        }
        return false
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
    
    func getAuthor() -> String {
        return self.post.author
    }
    
    func getUrl() -> String {
        return self.post.url
    }
    
    func manageImageResult(success: Bool) {
        if success {
            self.alertType = .message(message: Texts.PhotoSaved)
        } else {
            self.alertType = .message(message: Texts.SavePhotoError)
        }
    }
}
