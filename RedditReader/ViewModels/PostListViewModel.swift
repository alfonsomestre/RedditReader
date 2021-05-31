//
//  PostListViewModel.swift
//  RedditReader
//
//  Created by Alfonso Mestre on 29/5/21.
//

import Foundation

enum PostListViewModelAction: Identifiable, Equatable {
    
    var id: String { String(reflecting: self) }
    
    case showPost(post: PostViewModel)
    
    static func == (lhs: PostListViewModelAction, rhs: PostListViewModelAction) -> Bool {
        return lhs.id == rhs.id
    }
}

enum PostListAlertType: Identifiable {
    var id: String { String(reflecting: self) }
    
    case tryAgain
}

final class PostListViewModel: ObservableObject {
    
    @Published var posts: [PostViewModel] = []
    @Published var isLoadingContent: Bool = false
    @Published var action: PostListViewModelAction? = nil
    @Published var showTopicSheet: Bool = false
    @Published var alertType: PostListAlertType?
    var topic: Topic = .top
    
    private let serviceManager : RedditListingServiceManager
    
    private var after: String?
    
    init(_ manager: RedditListingServiceManager = RedditListingServiceManager()) {
        self.serviceManager = manager
        self.fetchReddits(firstTime: true)
    }
    
    func fetchReddits(firstTime: Bool = false) {
        self.isLoadingContent = true
        if firstTime {
            self.after = nil
        }
        self.serviceManager.getReddits(topic: topic, after: self.after, count: self.posts.count) { result in
            switch result {
            case .success(let listing):
                let posts = listing.data.children.map({$0.data})
                if firstTime {
                    self.posts = posts.map({PostViewModel(post: $0)})
                } else {
                    self.posts.append(contentsOf: posts.map({PostViewModel(post: $0)}))
                }
                self.after = listing.data.after
                self.isLoadingContent = false
            default:
                self.isLoadingContent = false
                if firstTime {
                    self.alertType = .tryAgain
                    self.posts = []
                }
            }
        }
    }
    
    func postSelected(post: PostViewModel) {
        if post.hasDetail() {
            self.action = .showPost(post: post)
        }
    }
}
