//
//  NetworkManager.swift
//  FriendListDemo
//
//  Created by Tsai Frank on 2024/11/7.
//

import Foundation
import Combine

class NetworkManager {
    private var cancellables: Set<AnyCancellable> = []
    
    func fetchData<T: Decodable>(endpoint: APIEndpoint, responseModel: T.Type) -> AnyPublisher<[T], Error> {
        let url = endpoint.url
        return URLSession.shared.dataTaskPublisher(for: url)
            .tryMap { (data, response) -> Data in
                guard let httpResponse = response as? HTTPURLResponse else {
                    throw NetworkError.invalidResponse
                }
                
                guard (200...299).contains(httpResponse.statusCode) else {
                    throw NetworkError.statusCodeError(httpResponse.statusCode)
                }
                
                return data
            }
            .mapError { error in
                if let networkError = error as? NetworkError {
                    return networkError
                } else {
                    return NetworkError.decodingError(error)
                }
            }
            .decode(type: ResponseModel<T>.self, decoder: JSONDecoder())
            .map { $0.response }
            .mapError { error in
                if let networkError = error as? NetworkError {
                    return networkError
                } else {
                    return NetworkError.decodingError(error)
                }
            }
            .eraseToAnyPublisher()
    }
}
