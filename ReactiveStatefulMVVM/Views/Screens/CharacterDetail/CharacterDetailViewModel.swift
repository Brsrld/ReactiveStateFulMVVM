//
//  CharacterDetailViewModel.swift
//  ReactiveStatefulMVVM
//
//  Created by Barış ŞARALDI on 28.09.2022.
//

import UIKit
import Combine


final class CharacterDetailViewModel {
    // MARK: Properties
    @Published private(set) var state: CharacterDetailState = .ready
    private var cancellable: AnyCancellable?
    private var service: ServiceGeneratorProtocol
    var characterDetail:Result
    
    // MARK: Init
    init(characterDetail: Result,service: ServiceGeneratorProtocol) {
        self.characterDetail = characterDetail
        self.service = service
    }
    
    private func loadImage() -> AnyPublisher<UIImage?, Never> {
        let url = URL(string: characterDetail.image ?? "")
        return Just(characterDetail.image)
            .flatMap({ UIImageView -> AnyPublisher<UIImage?, Never> in
                return self.service.getImages(from: url!)
            })
            .eraseToAnyPublisher()
    }
    
    func getImage() -> UIImage? {
        var result:UIImage?
        cancellable = loadImage().sink { image in
            result = image
        }
        return result
    }
}
