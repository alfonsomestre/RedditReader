//
//  PullToRefreshViewModelTests.swift
//  RedditReaderTests
//
//  Created by Alfonso Mestre on 31/5/21.
//

import XCTest
@testable import RedditReader

class PullToRefreshViewModelTests: XCTestCase {

    func test_is_on_beggining() {
        let viewModel = PullToRefreshViewModel(threshoudlReached: true, stoppedDragging: true, threshold: 30)
        viewModel.setFrameMinY(newMin: 10)
        viewModel.scrollOffset = 10
        XCTAssert(viewModel.isOnBeggining())
    }
    
    func test_has_reached_threshould() {
        let viewModel = PullToRefreshViewModel(threshoudlReached: false, stoppedDragging: false, threshold: 30)
        viewModel.setFrameMinY(newMin: 1)
        viewModel.scrollOffset = 32
        XCTAssert(viewModel.checkTreshouldReached())
    }
    
    func test_arrow_hidden() {
        let viewModel = PullToRefreshViewModel(threshoudlReached: false, stoppedDragging: false, threshold: 30)
        viewModel.setFrameMinY(newMin: 1)
        viewModel.scrollOffset = 1
        XCTAssert(viewModel.showArrow() == false)
    }
    
    func test_stopped_dragging() {
        let viewModel = PullToRefreshViewModel(threshoudlReached: true, stoppedDragging: false, threshold: 30)
        viewModel.setFrameMinY(newMin: 1)
        viewModel.scrollOffset = 1
        XCTAssert(viewModel.checkStoppedDragging() == true)
        
    }
}
