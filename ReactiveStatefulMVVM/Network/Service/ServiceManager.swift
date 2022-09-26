//
//  ServiceManager.swift
//  ReactiveStatefulMVVM
//
//  Created by Barış ŞARALDI on 26.09.2022.
//

import Foundation
import Combine

final class ServiceManager {
    public static let shared: ServiceManager = ServiceManager()
    private init () {}
}

extension ServiceManager {
    public func request<T>(_ req: NetworkRequest) -> AnyPublisher<T, NetworkError>
    where T: Decodable, T: Encodable {
        let sessionConfig = URLSessionConfiguration.default
        sessionConfig.timeoutIntervalForRequest = TimeInterval(req.requestTimeOut ?? 20)
        
        guard let url = URL(string: req.url) else {
            // Return a fail publisher if the url is invalid
            return AnyPublisher(
                Fail<T, NetworkError>(error: NetworkError.badURL("Invalid Url"))
            )
        }
        // We use the dataTaskPublisher from the URLSession which gives us a publisher to play around with.
        return URLSession.shared
            .dataTaskPublisher(for: req.buildURLRequest(with: url))
            .tryMap { output in
                // throw an error if response is nil
                guard output.response is HTTPURLResponse else {
                    throw NetworkError.serverError(code: 0, error: "Server error")
                }
                return output.data
            }
            .decode(type: T.self, decoder: JSONDecoder())
            .mapError { error in
                // return error if json decoding fails
                NetworkError.invalidJSON(String(describing: error))
            }
            .eraseToAnyPublisher()
    }
    
}
