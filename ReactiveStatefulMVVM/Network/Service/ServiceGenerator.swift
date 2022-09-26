//
//  ServiceGenerator.swift
//  ReactiveStatefulMVVM
//
//  Created by Barış ŞARALDI on 26.09.2022.
//

import Foundation
import Combine

protocol ServiceGenerator {
    func fetchCharacters(req: NetworkRequest) -> AnyPublisher<Characters, NetworkError>
}

final class Services: ServiceGenerator {
    let service: Service
    
    init(service:Service) {
        self.service = ServiceManager()
    }
    
    func fetchCharacters(req: NetworkRequest) -> AnyPublisher<Characters, NetworkError> {
        return service.request(req)
    }
}
