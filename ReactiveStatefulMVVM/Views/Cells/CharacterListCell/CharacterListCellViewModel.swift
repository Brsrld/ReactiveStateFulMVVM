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
    
    var characterSpecies: String {
        return character?.species ?? ""
    }
    
    var characterGender: String {
        return character?.gender ?? ""
    }
    
    var characterStatus: Status {
        return character?.status ?? .unknown
    }

}
