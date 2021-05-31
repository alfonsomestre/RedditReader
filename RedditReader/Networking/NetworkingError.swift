//
//  NetworkingError.swift
//  RedditReader
//
//  Created by Alfonso Mestre on 29/5/21.
//

import Foundation

enum NetworkingError: Error {
    case genericError
    case withDesc(data: Data)
    case withError(error: NSError)
}
