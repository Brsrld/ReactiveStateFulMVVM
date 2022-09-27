//
//  CharacterListBuilder.swift
//  ReactiveStatefulMVVM
//
//  Created by Barış ŞARALDI on 27.09.2022.
//

import UIKit

public final class CharacterListBuilder: NSObject, Buildable {
    public func build() -> UIViewController {
        guard let viewController = UIStoryboard.instantiateViewController(.characterList, CharacterListViewController.self) else {
            fatalError("Cannot be instantiated")
        }
        let service: ServiceGeneratorProtocol = ServiceGenerator()
        viewController.viewModel = CharacterListViewModel(service: service)
        
        return viewController
    }
}
