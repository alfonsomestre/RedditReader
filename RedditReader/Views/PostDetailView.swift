//
//  PostDetailView.swift
//  RedditReader
//
//  Created by Alfonso Mestre on 30/5/21.
//

import SwiftUI

struct PostDetailView: View {
    
    @ObservedObject var postDetailViewModel: PostDetailViewModel
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(alignment: .leading, spacing: 4.0) {
                    Text(self.postDetailViewModel.getSubrredit())
                        .font(.title3)
                        .opacity(0.5)
                    Text(self.postDetailViewModel.getAuthor())
                        .font(.subheadline)
                        .opacity(0.5)
                    Text(postDetailViewModel.getTitle())
                        .font(.title)
                        .bold()
                    if self.postDetailViewModel.shouldShowImage() {
                        ImageView(vm: ImageViewModel(urlString: self.postDetailViewModel.getUrl())) { data in
                            self.postDetailViewModel.imageData = data
                        }
                    }
                    HStack {
                        Spacer()
                        HStack(spacing: 2.0) {
                            Image(systemName: Images.clock)
                            Text("\(postDetailViewModel.getTimeSince())")
                                .font(.footnote)
                        }
                        Spacer()
                        HStack(spacing: 2.0) {
                            Image(systemName: Images.score)
                            Text(postDetailViewModel.getScoreKmValue())
                                .font(.footnote)
                        }
                        Spacer()
                        HStack(spacing: 2.0) {
                            Image(systemName: Images.comments)
                            Text(postDetailViewModel.getCommentsKmValue())
                                .font(.footnote)
                        }
                        Spacer()
                    }.opacity(0.75)
                }.padding(4)
            }
            .alert(item: self.$postDetailViewModel.alertType) { alert in
                switch alert {
                case .message(let message):
                    return Alert(title: Text(Texts.RedditReader), message: Text(message), dismissButton: Alert.Button.default(Text(Texts.Ok)))
                }
            }
            .navigationBarItems(
                trailing: Button(action: {
                    self.saveImage()
                },
                label: { Text(Texts.Save)})
            )
            .navigationBarTitle(Text(Texts.PostDetail), displayMode: .inline)
        }
    }
    
    func saveImage() {
        if let data = self.postDetailViewModel.imageData, let image = UIImage(data: data) {
            let imageSaver = ImageSaver(callbackFunc: { success in
                self.postDetailViewModel.manageImageResult(success: success)
            })
            imageSaver.writeToPhotoAlbum(image: image)
        }
    }
}

struct PostDetailView_Previews: PreviewProvider {
    static var previews: some View {
        
        let post = Post(title: "Before and after of the excavation of the Ancient Greek Stadium", id: "nn67r2", thumbnail: "https://b.thumbs.redditmedia.com/CmDB854t-TWxbrlQxPgwkiAQ9bkLvrZty-mtppYTNPM.jpg", url: "https://i.redd.it/9e5v2ymql9271.png", author: "WillOfTheLand", subreddit: "interestingasfuck", score: 105023, num_comments: 4930, created_utc: 1622383572.0, post_hint: "image")
        
        PostDetailView(postDetailViewModel: PostDetailViewModel(post: post))
    }
}
