//
//  CharacterListViewModel.swift
//  ReactiveStatefulMVVM
//
//  Created by Barış ŞARALDI on 26.09.2022.
//

import Foundation
import Combine


final class CharacterListViewModel {
    private let service: ServiceGeneratorProtocol
    private var bindings = Set<AnyCancellable>()
    private var isPaginating = false
    
    @Published private(set) var characters: Characters?
    @Published private(set) var state: CharacterListState = .ready
    
    var coordinator: Coordinator?
    
    enum Section { case character }
    
    init(service: ServiceGeneratorProtocol,coordinator: Coordinator?) {
        self.service = service
        self.coordinator = coordinator
    }
    
    func initialize() {
        let request = NetworkRequest(url: ApiURLs.baseURL.rawValue, httpMethod: .GET)
        getCharacters(request: request)
    }
    
    func doPagination(indexPath: IndexPath) {
        guard let count = characters?.results?.count else { return }
        guard let url = characters?.info?.next else { return }
        if indexPath.item == (count - 1) {
            let request = NetworkRequest(url: url, httpMethod: .GET)
            getCharacters(request: request)
            self.isPaginating = true
        }
    }
    
    private func getCharacters(request: NetworkRequest) {
        state = .loading
        service.fetchCharacters(req: request)
            .sink { [weak self] completion in
                switch completion {
                case .failure(let error):
                    self?.state = .error(error.localizedDescription)
                    self?.state = .finishedLoading
                case .finished:
                    self?.state = .finishedLoading
                }
            } receiveValue: { [weak self] response in
                if self?.characters?.info?.next == nil {
                    self?.characters = response
                } else {
                    guard let result = response.results else { return }
                    self?.characters?.info = response.info
                    self?.characters?.results! += result
                }
            }
            .store(in: &bindings)
    }
}

