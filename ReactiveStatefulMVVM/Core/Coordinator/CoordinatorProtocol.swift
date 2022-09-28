//
//  CoordinatorProtocol.swift
//  ReactiveStatefulMVVM
//
//  Created by Barış ŞARALDI on 27.09.2022.
//

import UIKit

enum Event {
    case goToDetail
}

protocol Coordinating {
    var coordinator: Coordinator? { get set }
}

protocol CoordinatorProtocol {
    var navigationController: UINavigationController? { get set }
    var parentCoordinator: CoordinatorProtocol? { get set }
    func eventOccurred(with type: Event, item: Result)
    func start()
}
