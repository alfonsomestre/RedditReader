//
//  PullToRefreshViewModel.swift
//  RedditReader
//
//  Created by Alfonso Mestre on 30/5/21.
//

import Foundation

final class PullToRefreshViewModel: ObservableObject {
    var frameMinY: Float?
    var scrollOffset: Float = 0
    var threshold: Float
    
    @Published var threshoudlReached: Bool
    @Published var stoppedDragging: Bool
    @Published var invalid : Bool = false

    init(threshoudlReached: Bool, stoppedDragging: Bool, threshold: Float) {
        self.threshoudlReached = threshoudlReached
        self.stoppedDragging = stoppedDragging
        self.threshold = threshold
    }
    func isOnBeggining() -> Bool {
        return self.frameMinY == self.scrollOffset
    }
    
    func showArrow() -> Bool {
        guard let frameMinY = frameMinY else {
            return false
        }
        return self.scrollOffset > frameMinY
    }
    
    func checkTreshouldReached() -> Bool {
        guard let frameMinY = frameMinY else {
            return false
        }
        return self.scrollOffset - frameMinY > self.threshold && !self.threshoudlReached
    }
    
    func checkStoppedDragging() -> Bool {
        return self.isOnBeggining()  && self.threshoudlReached && !self.stoppedDragging
    }
    
    func checkValidInteration() -> Bool {
        return self.isOnBeggining() && self.stoppedDragging && self.threshoudlReached && self.invalid
    }
    
    func setFrameMinY(newMin: Float) {
        if self.frameMinY == nil {
            if newMin > 0 {
                frameMinY = newMin
            } else {
                frameMinY = 91
            }
        }
    }
    
    func resetState() {
        self.stoppedDragging = false
        self.threshoudlReached = false
    }
}
