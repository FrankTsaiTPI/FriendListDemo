//
//  MockNetworkManager.swift
//  FriendListDemo
//
//  Created by Tsai Frank on 2024/11/13.
//

import Foundation
import Combine
@testable import FriendListDemo

class MockNetworkManager: NetworkManager {
    var shouldReturnError = false
    
    override func fetchData<T: Decodable>(endpoint: APIEndpoint, responseModel: T.Type) -> AnyPublisher<[T], any Error> {
        if shouldReturnError {
            return Fail(error: NSError(domain: "Error", code: -1, userInfo: [NSLocalizedDescriptionKey: "error"])) .eraseToAnyPublisher()
        } else {
            return loadJSON(fileName: endpoint.apiId, type: responseModel)
        }
    }
    
    private func loadJSON<T: Decodable>(fileName: String, type: T.Type) -> AnyPublisher<[T], Error> {
        let bundle = Bundle(for: MockNetworkManager.self)
        guard let url = bundle.url(forResource: fileName, withExtension: "json") else {
            fatalError("Could not find \(fileName).json")
        }
        
        do {
            let data = try Data(contentsOf: url)
            let decoder = JSONDecoder()
            let model = try decoder.decode(ResponseModel<T>.self, from: data)
            print("Successfully loaded \(fileName).json, model: \(model)")
            
            return Just(model.response)
                .setFailureType(to: Error.self)
                .eraseToAnyPublisher()
        } catch {
            print("Failed to decode \(fileName).json: \(error)")
            return Fail(error: error)
                .eraseToAnyPublisher()
        }
    }
}
