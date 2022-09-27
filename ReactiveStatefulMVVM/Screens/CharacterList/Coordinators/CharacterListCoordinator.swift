//
//  CharacterListCoordinator.swift
//  ReactiveStatefulMVVM
//
//  Created by Barış ŞARALDI on 26.09.2022.
//

import Foundation

public final class CharacterListCoordinator: Coordinator {
    var router: RouterProtocol
    
    public init(router: RouterProtocol) {
        self.router = router
    }
    
    func present(animated: Bool, completion: (() -> Void)?) {
        let builder = CharacterListBuilder()
        let vc = builder.build()
        router.present(vc, animated: true, completion: nil)
    }
    
    func dismiss(animated: Bool, completion: (() -> Void)?) {
        router.dismiss(animated: animated, completion: completion)
    }
}
