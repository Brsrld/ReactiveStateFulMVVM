//
//  Coordinator.swift
//  ReactiveStatefulMVVM
//
//  Created by Barış ŞARALDI on 28.09.2022.
//

import Foundation
import UIKit

class Coordinator: CoordinatorProtocol {
    
    // MARK: Properties
    var parentCoordinator: CoordinatorProtocol?
    var children: [CoordinatorProtocol] = []
    var navigationController: UINavigationController?
    
    // MARK: Funcs
    func start() {
        let vc = CharacterListBuilder.build(coordinator: self)
        navigationController?.setViewControllers([vc], animated: false)
    }

    func eventOccurred(with viewController: UIViewController) {
        navigationController?.pushViewController(viewController,
                                                 animated: true)
    }
}
