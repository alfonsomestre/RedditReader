//
//  RedditReaderTests.swift
//  RedditReaderTests
//
//  Created by Alfonso Mestre on 30/5/21.
//

import XCTest
@testable import RedditReader

class ImageViewModelTests: XCTestCase {

    func test_image_has_data() {
        let testServiceManager = RedditListingServiceManager(serviceProvider: RedditListingTestService())
        
        let viewModel = ImageViewModel(testServiceManager, urlString: "aUrl")
        
        viewModel.loadImage()
        
        XCTAssert(viewModel.data != nil)
        
    }
    
    func test_image_no_data() {
        let testService = RedditListingTestService(NetworkingError.genericError)
        let testServiceManager = RedditListingServiceManager(serviceProvider:testService)
        
        let viewModel = ImageViewModel(testServiceManager, urlString: "aUrl")
        
        viewModel.loadImage()
        
        XCTAssert(viewModel.data == nil)
    }

}
