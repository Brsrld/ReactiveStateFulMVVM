//
//  UIStoryboard+Extension.swift
//  ReactiveStatefulMVVM
//
//  Created by Barış ŞARALDI on 27.09.2022.
//

import UIKit

public extension UIStoryboard {
    
    class func instantiateViewController<T: UIViewController>(_ storyboardName: Storyboards, _: T.Type) -> T? {
        return UIStoryboard(name: storyboardName.rawValue, bundle: Bundle(identifier: "com.brsrld.ReactiveStatefulMVVM")).instantiateViewController(withIdentifier: String(describing: T.self)) as? T
    }
}
