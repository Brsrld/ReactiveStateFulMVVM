//
//  Router.swift
//  ReactiveStatefulMVVM
//
//  Created by Barış ŞARALDI on 27.09.2022.
//

import Foundation
import UIKit

public protocol RouterProtocol {
    var rootViewController: UIViewController { get }
    func present(_ viewController: UIViewController,
                 animated: Bool,
                 completion: (()-> Void)?)
    func dismiss(animated: Bool, completion: (() -> Void)?)
}
