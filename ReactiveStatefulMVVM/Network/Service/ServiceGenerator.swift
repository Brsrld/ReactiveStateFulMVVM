//
//  ServiceGenerator.swift
//  ReactiveStatefulMVVM
//
//  Created by Barış ŞARALDI on 26.09.2022.
//

import Foundation
import Combine

// MARK: Protocol
protocol ServiceGeneratorProtocol {
    func fetchCharacters(req: NetworkRequest) -> AnyPublisher<Characters, NetworkError>
}

final class ServiceGenerator: ServiceGeneratorProtocol {
    // MARK: Properties
    let service: ServiceManagerProtocol
    
    // MARK: Init
    init() {
        self.service = ServiceManager()
    }
    
    // MARK: Function
    func fetchCharacters(req: NetworkRequest) -> AnyPublisher<Characters, NetworkError> {
        return service.request(req)
    }
}
