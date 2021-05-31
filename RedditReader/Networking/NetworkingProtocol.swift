//
//  NetworkingProtocol.swift
//  RedditReader
//
//  Created by Alfonso Mestre on 29/5/21.
//

import Foundation

protocol NetworkingProtocol: AnyObject {
    func execute(_ endpoint: Endpoint, completion: @escaping (Result<Data, NetworkingError>) -> Void)
}
