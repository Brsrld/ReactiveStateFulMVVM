//
//  AppDelegateRooter.swift
//  ReactiveStatefulMVVM
//
//  Created by Barış ŞARALDI on 27.09.2022.
//

import UIKit

public class AppDelegateRouter: RouterProtocol {
    public var rootViewController: UIViewController
    
    // MARK: - Instance Properties
    public let window: UIWindow
    
    // MARK: - Object Lifecycle
    public init(window: UIWindow,rootViewController: UIViewController) {
        self.window = window
        self.rootViewController = rootViewController
    }
    
    // MARK: - Router
    public func present(_ viewController: UIViewController,
                        animated: Bool,
                        completion onDismissed: (()->Void)?) {
        window.rootViewController = viewController
        window.makeKeyAndVisible()
    }
    
    public func dismiss(animated: Bool, completion: (() -> Void)?) {
        // don't do anything
    }
}
