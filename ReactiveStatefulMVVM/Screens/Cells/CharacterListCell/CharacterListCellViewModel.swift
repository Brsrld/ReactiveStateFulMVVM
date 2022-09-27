//
//  CharacterListCellViewModel.swift
//  ReactiveStatefulMVVM
//
//  Created by Barış ŞARALDI on 27.09.2022.
//

import Foundation

struct CharacterListCellViewModel {
    
    private let character: Result?
    
    init(character: Result) {
        self.character = character
    }
    
    var imageURl: URL? {
        return URL(string: character?.image ?? "")
    }
    
    var characterName: String {
        return character?.name ?? ""
    }
    
    var characterSpecies: Species {
        return character?.species ?? .human
    }
    
    var characterGender: Gender {
        return character?.gender ?? .unknown
    }
    
    var characterStatus: Status {
        return character?.status ?? .unknown
    }

}
