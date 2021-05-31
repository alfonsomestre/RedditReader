//
//  Endpoint.swift
//  RedditReader
//
//  Created by Alfonso Mestre on 29/5/21.
//

import Foundation

public typealias Parameters = [String:Any]

class Endpoint {
    
    let url: URL
    let method: HTTPMethodType
    var params: Parameters?
    let timeOutInterval: TimeInterval
    
    init(url: URL, method: HTTPMethodType, params: Parameters?,
         headerParams: [String:String], timeOutInterval: TimeInterval = 60.0) {
        self.url = url
        self.method = method
        self.params = params
        self.timeOutInterval = timeOutInterval
    }
    
    func asURLRequest() throws -> URLRequest {
        var urlRequest = URLRequest(url: self.url)
        urlRequest.timeoutInterval = self.timeOutInterval
        urlRequest.httpMethod = self.method.rawValue
        try URLParameterEncoder().encode(urlRequest: &urlRequest, with: self.params)
        return urlRequest
    }
}

enum HTTPMethodType: String {
    case get    = "GET"
    case post   = "POST"
    case patch  = "PATCH"
}
