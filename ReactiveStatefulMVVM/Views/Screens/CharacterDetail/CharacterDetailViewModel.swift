//
//  CharacterDetailViewModel.swift
//  ReactiveStatefulMVVM
//
//  Created by Barış ŞARALDI on 28.09.2022.
//

import Foundation
import Combine


final class CharacterDetailViewModel {
    // MARK: Properties
    @Published private(set) var state: CharacterDetailState = .ready
    var characterDetail:Result
    
    // MARK: Init
    init(characterDetail: Result) {
        self.characterDetail = characterDetail
    }
}
