//
//  PullToRefreshView.swift
//  RedditReader
//
//  Created by Alfonso Mestre on 30/5/21.
//

import SwiftUI

struct PullToRefreshView<Content: View>: View {
    
    let refreshData: () -> ()
    let content: () -> Content
    
    @StateObject var pullToRefreshViewModel: PullToRefreshViewModel = PullToRefreshViewModel(threshoudlReached: false, stoppedDragging: false, threshold: 30)
    
    var body: some View {
        
        ScrollView(.vertical, showsIndicators: true) {
            GeometryReader { geometry -> AnyView in
                DispatchQueue.main.async {
                    self.pullToRefreshViewModel.setFrameMinY(newMin: Float(geometry.frame(in: .global).minY))
                    self.pullToRefreshViewModel.scrollOffset = Float(geometry.frame(in: .global).minY)
                    if self.pullToRefreshViewModel.checkTreshouldReached() {
                        self.pullToRefreshViewModel.threshoudlReached = true
                    }

                    if self.pullToRefreshViewModel.checkStoppedDragging() {
                        withAnimation() {
                            self.pullToRefreshViewModel.stoppedDragging = true
                            self.update()
                        }
                    }

                    if self.pullToRefreshViewModel.checkValidInteration() {
                        withAnimation() {
                            self.pullToRefreshViewModel.invalid = false
                            self.update()
                        }
                    }
                }
                
                return AnyView(EmptyView())
            }.frame(width: 0, height: 0)
            
            ZStack(alignment: Alignment(horizontal: .center, vertical: .top)) {
                if self.pullToRefreshViewModel.threshoudlReached && self.pullToRefreshViewModel.stoppedDragging {
                    ProgressView()
                } else {
                    Image(systemName: Images.arrowDown)
                        .rotationEffect(.init(degrees: self.pullToRefreshViewModel.threshoudlReached ? 180 : 0))
                        .animation(.easeIn)
                        .opacity(self.pullToRefreshViewModel.showArrow() ? 1 : 0)
                }
                content()
            }
        }
    }
    
    private func update() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            withAnimation {
                if self.pullToRefreshViewModel.isOnBeggining() {
                    self.refreshData()
                    self.pullToRefreshViewModel.resetState()
                } else {
                    self.pullToRefreshViewModel.invalid = true
                    self.pullToRefreshViewModel.resetState()
                }
            }
        }
    }
}

struct PullToRefreshView_Previews: PreviewProvider {
    static var previews: some View {
        PullToRefreshView(refreshData: {}) {
            EmptyView()
        }
    }
}
