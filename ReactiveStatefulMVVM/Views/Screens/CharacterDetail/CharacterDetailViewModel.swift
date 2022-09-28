//
//  CharacterDetailViewModel.swift
//  ReactiveStatefulMVVM
//
//  Created by Barış ŞARALDI on 28.09.2022.
//

import Foundation
import Combine


final class CharacterDetailViewModel {
    @Published private(set) var state: CharacterDetailState = .ready
    var characterDetail:Result
    
    init(characterDetail: Result) {
        self.characterDetail = characterDetail
    }
}
