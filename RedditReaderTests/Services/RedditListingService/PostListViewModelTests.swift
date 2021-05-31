//
//  PostListViewModelTests.swift
//  RedditReaderTests
//
//  Created by Alfonso Mestre on 31/5/21.
//

import XCTest
@testable import RedditReader

class PostListViewModelTests: XCTestCase {

    func test_get_posts() {
        let testServiceManager = RedditListingServiceManager(serviceProvider: RedditListingTestService())
        
        let viewModel = PostListViewModel(testServiceManager)
        
        viewModel.fetchReddits(firstTime: true)
        
        XCTAssert(viewModel.posts.count == 2)
    }
    
    func test_get_paginated_posts() {
        let testServiceManager = RedditListingServiceManager(serviceProvider: RedditListingTestService())
        
        let viewModel = PostListViewModel(testServiceManager)
        
        viewModel.fetchReddits(firstTime: true)
        viewModel.fetchReddits()
        
        XCTAssert(viewModel.posts.count == 4)
    }
    
    func test_paginate_and_pull_to_refresh() {
        let testServiceManager = RedditListingServiceManager(serviceProvider: RedditListingTestService())
        
        let viewModel = PostListViewModel(testServiceManager)
        
        viewModel.fetchReddits(firstTime: true)
        viewModel.fetchReddits()
        viewModel.fetchReddits()
        viewModel.fetchReddits(firstTime: true)
        
        XCTAssert(viewModel.posts.count == 2)
    }
    
    func test_not_supported_post_selected() {
        let testServiceManager = RedditListingServiceManager(serviceProvider: RedditListingTestService())
        
        let viewModel = PostListViewModel(testServiceManager)
        
        let post = Post(title: "Before and after of the excavation of the Ancient Greek Stadium", id: "nn67r2", thumbnail: "", url: "https://i.redd.it/9e5v2ymql9271.png", author: "WillOfTheLand", subreddit: "interestingasfuck", score: 105023, num_comments: 4930, created_utc: 1622383572.0, post_hint: "hosted:video")
        
        viewModel.postSelected(post: PostViewModel(post: post))
        
        XCTAssert(viewModel.action == nil)
        
    }
    
    func test_supported_post_selected() {
        let testServiceManager = RedditListingServiceManager(serviceProvider: RedditListingTestService())
        
        let viewModel = PostListViewModel(testServiceManager)
        
        let post = Post(title: "Before and after of the excavation of the Ancient Greek Stadium", id: "nn67r2", thumbnail: "", url: "https://i.redd.it/9e5v2ymql9271.png", author: "WillOfTheLand", subreddit: "interestingasfuck", score: 105023, num_comments: 4930, created_utc: 1622383572.0, post_hint: "image")
        
        let postVM = PostViewModel(post: post)
        viewModel.postSelected(post: postVM)
        
        XCTAssert(viewModel.action == PostListViewModelAction.showPost(post: postVM))
    }

}
