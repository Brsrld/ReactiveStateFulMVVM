//
//  CharacterListViewModel.swift
//  ReactiveStatefulMVVM
//
//  Created by Barış ŞARALDI on 26.09.2022.
//

import Foundation
import Combine


final class CharacterListViewModel: ObservableObject {
    
    private let service: ServiceGeneratorProtocol
    private var bindings = Set<AnyCancellable>()
    
    @Published private(set) var characters: Characters?
    @Published private(set) var state: CharacterListState = .ready
    
    enum Section { case character }
    
    init(service: ServiceGeneratorProtocol) {
        self.service = service
    }
    
    func getLaunches() {
        let url = "https://rickandmortyapi.com/api/character"
        let request = NetworkRequest(url: url, httpMethod: .GET)
        state = .loading
        service.fetchCharacters(req: request)
            .sink { [weak self] completion in
                switch completion {
                case .failure(let error):
                    self?.state = .error(error.localizedDescription)
                case .finished:
                    self?.state = .finishedLoading
                }
            } receiveValue: { [weak self] response in
                self?.characters = response
            }
            .store(in: &bindings)
    }
}

extension CharacterListViewModel: CharacterCollectionViewDataModelOutput {
    func onDidSelect(indexPath: IndexPath) {
        //        coordinator?.eventOccurred(with: .goToDetail,
        //                                   item: self.launchs[indexPath.item])
    }
    
    func onWillDisplay(indexPath: IndexPath) {
        //        if indexPath.item == (launchs.count - Constant.LastItemCountofStartPagination)
        //            && !isPaginating {
        //            self.offset += launchs.count
        //            getLaunches()
        //            self.isPaginating = true
    }
}
