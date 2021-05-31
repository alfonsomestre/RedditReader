//
//  PostViewModelTests.swift
//  RedditReaderTests
//
//  Created by Alfonso Mestre on 31/5/21.
//

import XCTest
@testable import RedditReader

class PostViewModelTests: XCTestCase {

    func test_has_not_detail() {
        let post = Post(title: "Before and after of the excavation of the Ancient Greek Stadium", id: "nn67r2", thumbnail: "", url: "https://i.redd.it/9e5v2ymql9271.png", author: "WillOfTheLand", subreddit: "interestingasfuck", score: 105023, num_comments: 4930, created_utc: 1622383572.0, post_hint: "hosted:video")
        
        let viewModel = PostViewModel(post: post)
        
        XCTAssert(viewModel.hasDetail() == false)
    }
    
    func test_has_detail() {
        let post = Post(title: "Before and after of the excavation of the Ancient Greek Stadium", id: "nn67r2", thumbnail: "", url: "https://i.redd.it/9e5v2ymql9271.png", author: "WillOfTheLand", subreddit: "interestingasfuck", score: 105023, num_comments: 4930, created_utc: 1622383572.0, post_hint: "image")
        
        let viewModel = PostViewModel(post: post)
        
        XCTAssert(viewModel.hasDetail() == true)
    }
    
    func test_has_thumbnail_url() {
        let post = Post(title: "Before and after of the excavation of the Ancient Greek Stadium", id: "nn67r2", thumbnail: "https://b.thumbs.redditmedia.com/wvgbkokOnwfx0aobT_3z06vjawupzkARttjgtGpdXPU.jpg", url: "https://i.redd.it/9e5v2ymql9271.png", author: "WillOfTheLand", subreddit: "interestingasfuck", score: 105023, num_comments: 4930, created_utc: 1622383572.0, post_hint: "image")
        
        let viewModel = PostViewModel(post: post)
        
        XCTAssert(viewModel.getImageURL() != nil)
    }

}
