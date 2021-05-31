//
//  RedditReaderApp.swift
//  RedditReader
//
//  Created by Alfonso Mestre on 29/5/21.
//

import SwiftUI

@main
struct RedditReaderApp: App {
    var body: some Scene {
        WindowGroup {
            PostListView(vm: PostListViewModel())
        }
    }
}
