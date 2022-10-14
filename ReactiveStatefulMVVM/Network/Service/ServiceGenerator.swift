//
//  ServiceGenerator.swift
//  ReactiveStatefulMVVM
//
//  Created by Barış ŞARALDI on 26.09.2022.
//

import Foundation
import Combine
import UIKit

// MARK: Protocol
protocol ServiceGeneratorProtocol {
    func fetchCharacters(req: NetworkRequest) -> AnyPublisher<Characters, NetworkError>
    func getImages(from url: URL) -> AnyPublisher<UIImage?, Never>
}

final class ServiceGenerator: ServiceGeneratorProtocol {
    // MARK: Properties
    let service: ServiceManagerProtocol
    private let cache: ImageCacheType
    private lazy var backgroundQueue: OperationQueue = {
        let queue = OperationQueue()
        queue.maxConcurrentOperationCount = 5
        return queue
    }()
    
    // MARK: Init
    init() {
        self.service = ServiceManager()
        self.cache = ImageCache()
    }
    
    // MARK: Function
    func fetchCharacters(req: NetworkRequest) -> AnyPublisher<Characters, NetworkError> {
        return service.request(req)
    }
    
    func getImages(from url: URL) -> AnyPublisher<UIImage?, Never>  {
        return service.loadImage(from: url, cache: cache, backgroundQueue: backgroundQueue)
    }
}
