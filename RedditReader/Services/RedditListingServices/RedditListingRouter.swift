//
//  RedditListingRouter.swift
//  RedditReader
//
//  Created by Alfonso Mestre on 29/5/21.
//

import Foundation

enum Topic: String, CaseIterable {
    case hot
    case new
    case controversial
    case top
    case rising
}

enum RedditListingRouter {
    static let baseURLString = "https://www.reddit.com"
    
    case getReddits(topic: Topic, after: String?, count: Int)
    case getImage(imageUrl: String)
    
    private var httpMethod: HTTPMethodType {
        switch self {
        case .getReddits, .getImage:
            return .get
        }
    }
    
    private var path: String {
        switch self {
        case .getReddits(let topic, _, _):
            return String(format: RedditRouterKeys.EndPoints.getReddits, topic.rawValue)
        case .getImage:
            return ""
        }
    }
    
    // MARK: URLRequest
    
    func endpoint() throws -> Endpoint {
        var urlString: String
        
        switch self {
        case .getImage(let imageUrl):
            urlString = imageUrl
        default:
            urlString = RedditListingRouter.baseURLString
        }
        
        guard let url = URL(string: urlString) else {
            throw NetworkingError.genericError
        }
        
        let finalUrl: URL = {
            switch self {
            case .getImage:
                return url
            default:
                return url.appendingPathComponent(path)
            }
        }()
        let headerParams: [String: String] = [:]
        
        let parameters: Parameters? = {
            switch self {
            case .getReddits(_, let after, let count):
                var params: [String: Any] = [:]
                if let after = after {
                    params[RedditRouterKeys.Parameters.After] = after
                }
                params[RedditRouterKeys.Parameters.Count] = count
                return params
            default:
                return nil
            }
        }()
        
        return Endpoint(url: finalUrl,
                        method: httpMethod,
                        params: parameters,
                        headerParams: headerParams)
    }
}

struct RedditRouterKeys {
    struct EndPoints {
        static let getReddits                           = "/%@.json"
    }

    struct Parameters {
        static let After                                = "after"
        static let Count                                = "count"
    }
}
