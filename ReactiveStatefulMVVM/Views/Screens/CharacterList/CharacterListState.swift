//
//  CharacterListState.swift
//  ReactiveStatefulMVVM
//
//  Created by Barış ŞARALDI on 26.09.2022.
//

import Foundation

public enum CharacterListState: Equatable {
    case loading
    case ready
    case finishedLoading
    case error(String)
}
