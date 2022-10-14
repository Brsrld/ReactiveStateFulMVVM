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
    
    private func loadImage(imageView:UIImageView) -> AnyPublisher<UIImage?, Never> {
        let url = URL(string: characterDetail.image ?? "")
        return Just(characterDetail.image)
            .flatMap({ imageView -> AnyPublisher<UIImage?, Never> in
                return self.service.getImages(from: url!)
            })
            .eraseToAnyPublisher()
    }
    
    func getImage(imageView:UIImageView) -> UIImage? {
        var result:UIImage?
        cancellable = loadImage(imageView: imageView).sink { image in
            result = image
        }
        return result
    }
}
