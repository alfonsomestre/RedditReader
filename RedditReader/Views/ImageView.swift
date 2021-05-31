//
//  ImageView.swift
//  RedditReader
//
//  Created by Alfonso Mestre on 29/5/21.
//

import SwiftUI

struct ImageView: View {
    
    @StateObject var vm: ImageViewModel
    var saveImageClosure: ((_ data: Data) -> Void)?
    
    var body: some View {
        VStack {
            if let data = self.vm.data {
                self.getImage(data: data)
            } else {
                HStack {
                    Spacer()
                    ProgressView()
                    Spacer()
                }
            }
        }.onAppear() {
            self.vm.loadImage()
        }
    }
    
    func getImage(data: Data) -> AnyView {
        if let image = UIImage(data: data) {
            self.saveImageClosure?(data)
            return AnyView(Image(uiImage: image)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .cornerRadius(4))
        } else {
            return AnyView(EmptyView())
        }
    }
}

struct ImageView_Previews: PreviewProvider {
    static var previews: some View {
        ImageView(vm: ImageViewModel(urlString: "https://b.thumbs.redditmedia.com/BYPWc9u5lkRUSI4rABV9jn68dHEivS8MlsDNutFxOlM.jpg"))
    }
}
