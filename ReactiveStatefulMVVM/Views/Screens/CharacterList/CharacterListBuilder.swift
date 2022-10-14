//
//  CharacterListBuilder.swift
//  ReactiveStatefulMVVM
//
//  Created by Barış ŞARALDI on 27.09.2022.
//

import UIKit

enum CharacterListBuilder {
    static func build(coordinator: Coordinator) -> UIViewController {
        guard let viewController = UIStoryboard.instantiateViewController(.characterList, CharacterListViewController.self) else {
            fatalError("Cannot be instantiated")
        }
        
        let service: ServiceGeneratorProtocol = ServiceGenerator()
        let viewModel = CharacterListViewModel(service: service)
        
        viewController.viewModel = viewModel
        viewController.coordinator = coordinator
        
        return viewController
    }
}
