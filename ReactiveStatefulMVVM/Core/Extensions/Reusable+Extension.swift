//
//  Reusable+Extension.swift
//  ReactiveStatefulMVVM
//
//  Created by Barış ŞARALDI on 27.09.2022.
//

protocol Reusable: AnyObject {
    static var reuseIdentifier: String { get }
}

extension Reusable {
    static var reuseIdentifier: String { return String(describing: Self.self) }
}
