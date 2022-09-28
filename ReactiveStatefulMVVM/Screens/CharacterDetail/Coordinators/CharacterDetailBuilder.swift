//
//  CharacterDetailBuilder.swift
//  ReactiveStatefulMVVM
//
//  Created by Barış ŞARALDI on 28.09.2022.
//

import Foundation
import UIKit

public final class CharacterDetailBuilder: NSObject, Buildable {
    let characterDetail:Result
    
    init(characterDetail:Result) {
        self.characterDetail = characterDetail
    }
    
    public func build() -> UIViewController {
        guard let viewController = UIStoryboard.instantiateViewController(.characterDetail, CharacterDetailViewController.self) else {
            fatalError("Cannot be instantiated")
        }
        
        viewController.viewModel = CharacterDetailViewModel(characterDetail: characterDetail)
        
        return viewController
    }
}
