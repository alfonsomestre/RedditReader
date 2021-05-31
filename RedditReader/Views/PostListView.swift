//
//  PostListView.swift
//  RedditReader
//
//  Created by Alfonso Mestre on 29/5/21.
//

import SwiftUI

struct PostListView: View {
    @ObservedObject var vm: PostListViewModel
    
    var body: some View {
        NavigationView {
            ZStack {
                Color(Colors.backgroundColor)
                PullToRefreshView(refreshData: {
                    self.vm.fetchReddits(firstTime: true)
                }) {
                    LazyVStack(spacing: 0.0) {
                        ForEach(self.vm.posts) { reddit in
                            Button(action: {
                                self.vm.postSelected(post: reddit)
                            }, label: {
                                PostView(postVM: reddit)
                                .onAppear() {
                                    if reddit == self.vm.posts.last {
                                        self.vm.fetchReddits()
                                    }
                                }
                                .padding()
                            }).buttonStyle(PlainButtonStyle())
                        }
                        if self.vm.isLoadingContent {
                          HStack {
                            Spacer()
                            ProgressView()
                                .padding(.top)
                            Spacer()
                          }
                        }
                    }
                }
                .alert(item: self.$vm.alertType) { alert in
                    switch alert {
                    case .tryAgain:
                        let primaryButton = Alert.Button.default(Text(Texts.TryAgain), action: {
                            self.vm.fetchReddits(firstTime: true)
                        })
                        return Alert(title: Text(Texts.RedditReader),
                                     message: Text(Texts.Error),
                                     dismissButton: primaryButton)
                    }
                }
                .actionSheet(isPresented: self.$vm.showTopicSheet) {
                    ActionSheet(title: Text(Texts.Topics), buttons: Topic.allCases.map { method in
                        ActionSheet.Button.default(
                            Text(method.rawValue)
                        ) {
                            self.vm.topic = method
                            self.vm.fetchReddits(firstTime: true)
                        }
                    })
                }
                .sheet(item: self.$vm.action) { action in
                    switch action {
                    case .showPost(let postVM):
                        PostDetailView(postDetailViewModel: PostDetailViewModel(post: postVM.getPost()))
                    }
                }
            }
            .navigationBarItems(trailing: HStack {
                Button(action: {
                    self.vm.showTopicSheet.toggle()
                }) {
                    Text(self.vm.topic.rawValue)
                }
            })
            .navigationBarTitle(Text(Texts.RedditReader), displayMode: .inline)
        }
    }

}

struct PostListView_Previews: PreviewProvider {
    static var previews: some View {
        PostListView(vm: PostListViewModel())
    }
}
