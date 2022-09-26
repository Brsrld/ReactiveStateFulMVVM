//
//  ServiceGenerator.swift
//  ReactiveStatefulMVVM
//
//  Created by Barış ŞARALDI on 26.09.2022.
//

import Foundation
import Alamofire
import Combine

protocol ServiceGenerator {
    func fetchCharacters(req: NetworkRequest) -> AnyPublisher<Characters, NetworkError>
}

final class Services: ServiceGenerator {
    func fetchCharacters(req: NetworkRequest) -> AnyPublisher<Characters, NetworkError> {
        return ServiceManager.shared.request(req)
    }
}
