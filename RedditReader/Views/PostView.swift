//
//  PostView.swift
//  RedditReader
//
//  Created by Alfonso Mestre on 29/5/21.
//

import SwiftUI

struct PostView: View {
    
    let postVM: PostViewModel
    
    var body: some View {
        VStack {
            HStack {
                VStack(alignment: .leading, spacing: 4.0) {
                    Text(self.postVM.getSubrredit())
                        .font(.title3)
                        .opacity(0.5)
                    HStack {
                        Text(postVM.getTitle())
                            .lineLimit(2)
                            .font(.title3)
                    }
                    HStack {
                        HStack(spacing: 2.0) {
                            Image(systemName: Images.clock)
                            Text("\(postVM.getTimeSince())")
                                .font(.footnote)
                        }
                        HStack(spacing: 2.0) {
                            Image(systemName: Images.score)
                            Text(postVM.getScoreKmValue())
                                .font(.footnote)
                        }
                        HStack(spacing: 2.0) {
                            Image(systemName: Images.comments)
                            Text(postVM.getCommentsKmValue())
                                .font(.footnote)
                        }
                    }.opacity(0.75)
                }
                Spacer()
                if let url = self.postVM.getImageURL(), UIApplication.shared.canOpenURL(url) {
                    ImageView(vm: ImageViewModel(urlString: self.postVM.getThumbnail()))
                        .frame(width: 75, height: 75, alignment: .center)
                }
                if self.postVM.hasDetail() {
                    Spacer()
                    Image("disclosure")
                        .opacity(0.75)
                        .aspectRatio(contentMode: .fit)
                }
            }
            Divider()
        }
        .padding()
        .background(Color.white)
        .cornerRadius(4.0)
    }
}

struct PostView_Previews: PreviewProvider {
    static var previews: some View {
        
        let post = Post(title: "Before and after of the excavation of the Ancient Greek Stadium", id: "nn67r2", thumbnail: "https://b.thumbs.redditmedia.com/wvgbkokOnwfx0aobT_3z06vjawupzkARttjgtGpdXPU.jpg", url: "https://i.redd.it/fxb0wimcaw171.png", author: "lrlOurPresident", subreddit: "interestingasfuck", score: 125332, num_comments: 2221, created_utc: 1622226514.0, post_hint: "image")
        
        PostView(postVM: PostViewModel(post: post))
    }
}
