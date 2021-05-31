//
//  NetworkingURLSession.swift
//  RedditReader
//
//  Created by Alfonso Mestre on 29/5/21.
//

import Foundation

final class NetworkingURLSession: NetworkingProtocol {
    
    let session: URLSession
    
    init(urlSessionConfig: URLSessionConfiguration = .default) {
        self.session = URLSession(configuration: urlSessionConfig)
    }
    
    func execute(_ endpoint: Endpoint, completion: @escaping (Result<Data, NetworkingError>) -> Void) {
        do {
            let request = try endpoint.asURLRequest()
            let dataTask = session.dataTask(with: request) { data, response, error in
                if let error = error {
                    DispatchQueue.main.async {
                        completion(.failure(NetworkingError.withError(error: error as NSError)))
                    }
                } else {
                    guard let httpResponse = response as? HTTPURLResponse else {
                        DispatchQueue.main.async {
                            completion(.failure(NetworkingError.genericError))
                        }
                        return
                    }
                    switch httpResponse.statusCode {
                    case StatusCode.Ok:
                        if let data = data {
                            DispatchQueue.main.async {
                                completion(.success(data))
                            }
                        } else {
                            DispatchQueue.main.async {
                                completion(.failure(NetworkingError.genericError))
                            }
                        }
                    default:
                        if let data = data {
                            DispatchQueue.main.async {
                                completion(.failure(NetworkingError.withDesc(data: data)))
                            }
                        } else {
                            DispatchQueue.main.async {
                                completion(.failure(NetworkingError.genericError))
                            }
                            
                        }
                    }
                }
            }
            dataTask.resume()
        } catch {
            completion(.failure(NetworkingError.genericError))
        }
    }
}

struct StatusCode {
    static let Ok                       = 200
}
