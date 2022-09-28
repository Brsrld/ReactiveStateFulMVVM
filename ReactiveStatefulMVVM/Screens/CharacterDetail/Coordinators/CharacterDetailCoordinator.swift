//
//  CharacterDetailCoordinator.swift
//  ReactiveStatefulMVVM
//
//  Created by Barış ŞARALDI on 28.09.2022.
//

import Foundation

public final class CharacterDetailCoordinator: Coordinator {
    var router: RouterProtocol
    let characterDetail:Result
    
    init(router: RouterProtocol, characterDetail:Result) {
        self.router = router
        self.characterDetail = characterDetail
    }
    
    func present(animated: Bool, completion: (() -> Void)?) {
        let builder = CharacterDetailBuilder(characterDetail: characterDetail)
        let vc = builder.build()
        router.present(vc, animated: true, completion: nil)
    }
    
    func dismiss(animated: Bool, completion: (() -> Void)?) {
        router.dismiss(animated: animated, completion: completion)
    }
}
