//
//  RedditListingService.swift
//  RedditReader
//
//  Created by Alfonso Mestre on 29/5/21.
//

import Foundation

final class RedditListingService: RedditListingServiceProtocol {
    
    private let networking: NetworkingProtocol
    
    init(_ networking: NetworkingProtocol) {
        self.networking = networking
    }
    
    func getReddits(topic: Topic, after: String?, count: Int, completion: @escaping(Result<Listing, NetworkingError>) -> Void) {
        do {
            let request = try RedditListingRouter.getReddits(topic: topic, after: after, count: count).endpoint()
            self.networking.execute(request) { result in
                switch result {
                case .success(let data):
                    if let object = try? JSONDecoder().decode(Listing.self, from: data) {
                        completion(.success(object))
                    } else {
                        completion(.failure(.genericError))
                    }
                    
                case .failure(let networkingError):
                    completion(.failure(networkingError))
                }
            }
        } catch {
            completion(.failure(.genericError))
        }
    }

    func getImage(imageUrl: String, completion: @escaping(Result<Data, NetworkingError>) -> Void) {
        do {
            let request = try RedditListingRouter.getImage(imageUrl: imageUrl).endpoint()
            self.networking.execute(request) { result in
                switch result {
                case .success(let data):
                    completion(.success(data))
                case .failure(let networkingError):
                    completion(.failure(networkingError))
                }
            }
        } catch {
            completion(.failure(.genericError))
        }
    }
}
