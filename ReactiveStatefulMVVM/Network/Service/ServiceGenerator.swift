//
//  ServiceGenerator.swift
//  ReactiveStatefulMVVM
//
//  Created by Barış ŞARALDI on 26.09.2022.
//

import Foundation
import Combine

protocol ServiceGeneratorProtocol {
    func fetchCharacters(req: NetworkRequest) -> AnyPublisher<Characters, NetworkError>
}

final class ServiceGenerator: ServiceGeneratorProtocol {
    let service: ServiceManagerProtocol
    
    init() {
        self.service = ServiceManager()
    }
    
    func fetchCharacters(req: NetworkRequest) -> AnyPublisher<Characters, NetworkError> {
        return service.request(req)
    }
}
