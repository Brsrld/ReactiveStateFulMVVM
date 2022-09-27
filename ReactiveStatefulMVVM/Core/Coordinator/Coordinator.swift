//
//  Coordinator.swift
//  ReactiveStatefulMVVM
//
//  Created by Barış ŞARALDI on 27.09.2022.
//

import Foundation

protocol Coordinator {
    var router: RouterProtocol { get }
    func present(animated: Bool, completion: (() -> Void)?)
    func dismiss(animated: Bool, completion: (() -> Void)?)
}
