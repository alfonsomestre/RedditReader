//
//  PostDetailViewModelTests.swift
//  RedditReaderTests
//
//  Created by Alfonso Mestre on 31/5/21.
//

import XCTest
@testable import RedditReader

class PostDetailViewModelTests: XCTestCase {

    func test_shouldnt_show_image() {
        let post = Post(title: "Before and after of the excavation of the Ancient Greek Stadium", id: "nn67r2", thumbnail: "", url: "https://i.redd.it/9e5v2ymql9271.png", author: "WillOfTheLand", subreddit: "interestingasfuck", score: 105023, num_comments: 4930, created_utc: 1622383572.0, post_hint: "image")
        
        let viewModel = PostDetailViewModel(post: post)
        
        XCTAssert(viewModel.shouldShowImage() == false)
    }
    
    func test_save_image_success() {
        let post = Post(title: "Before and after of the excavation of the Ancient Greek Stadium", id: "nn67r2", thumbnail: "", url: "https://i.redd.it/9e5v2ymql9271.png", author: "WillOfTheLand", subreddit: "interestingasfuck", score: 105023, num_comments: 4930, created_utc: 1622383572.0, post_hint: "image")
        
        let viewModel = PostDetailViewModel(post: post)
        
        viewModel.manageImageResult(success: true)
        
        XCTAssert(viewModel.alertType == PostDetailViewModelAlertType.message(message: Texts.PhotoSaved))
    }
    
    func test_save_image_error() {
        let post = Post(title: "Before and after of the excavation of the Ancient Greek Stadium", id: "nn67r2", thumbnail: "", url: "https://i.redd.it/9e5v2ymql9271.png", author: "WillOfTheLand", subreddit: "interestingasfuck", score: 105023, num_comments: 4930, created_utc: 1622383572.0, post_hint: "image")
        
        let viewModel = PostDetailViewModel(post: post)
        
        viewModel.manageImageResult(success: false)
        
        XCTAssert(viewModel.alertType == PostDetailViewModelAlertType.message(message: Texts.SavePhotoError))
    }
    
    func test_k_logic() {
        let post = Post(title: "Before and after of the excavation of the Ancient Greek Stadium", id: "nn67r2", thumbnail: "", url: "https://i.redd.it/9e5v2ymql9271.png", author: "WillOfTheLand", subreddit: "interestingasfuck", score: 105023, num_comments: 4930, created_utc: 1622383572.0, post_hint: "image")
        
        let viewModel = PostDetailViewModel(post: post)
        
        XCTAssert(viewModel.getScoreKmValue() == "105k")
        XCTAssert(viewModel.getCommentsKmValue() == "4k")
    }
    
    func test_m_logic() {
        let post = Post(title: "Before and after of the excavation of the Ancient Greek Stadium", id: "nn67r2", thumbnail: "", url: "https://i.redd.it/9e5v2ymql9271.png", author: "WillOfTheLand", subreddit: "interestingasfuck", score: 1000000, num_comments: 2000000, created_utc: 1622383572.0, post_hint: "image")
        
        let viewModel = PostDetailViewModel(post: post)
        
        XCTAssert(viewModel.getScoreKmValue() == "1m")
        XCTAssert(viewModel.getCommentsKmValue() == "2m")
    }
}
