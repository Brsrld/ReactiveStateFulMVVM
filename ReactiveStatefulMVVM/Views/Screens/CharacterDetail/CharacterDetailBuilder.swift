//
//  CharacterDetailBuilder.swift
//  ReactiveStatefulMVVM
//
//  Created by Barış ŞARALDI on 28.09.2022.
//

import Foundation
import UIKit

enum CharacterDetailBuilder {
    static func build(characterDetail: Result, service:ServiceGeneratorProtocol) -> UIViewController {
        guard let viewController = UIStoryboard.instantiateViewController(.characterDetail, CharacterDetailViewController.self) else {
            fatalError("Cannot be instantiated")
        }
        
        let viewModel = CharacterDetailViewModel(characterDetail: characterDetail, service:service)
        viewController.viewModel = viewModel
        
        return viewController
    }
}
