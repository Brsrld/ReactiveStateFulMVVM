//
//  RickAndMortyModel.swift
//  ReactiveStatefulMVVM
//
//  Created by Barış ŞARALDI on 26.09.2022.
//

import Foundation

// MARK: - Characters
struct Characters: Codable,Hashable {
    var info: Info?
    var results: [Result]?
    
    static func == (lhs: Characters, rhs: Characters) -> Bool {
        return lhs.results == rhs.results && lhs.info == rhs.info
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(results)
        hasher.combine(info)
    }
}

// MARK: - Info
struct Info: Codable,Hashable {
    let count, pages: Int?
    let next: String?
    let prev: String?
}

// MARK: - Result
struct Result: Codable,Hashable {
    let id: Int?
    let name: String?
    let status: Status?
    let species: String?
    let type: String?
    let gender: String?
    let origin, location: Location?
    let image: String?
    let episode: [String]?
    let url: String?
    let created: String?
    
    static func == (lhs: Result, rhs: Result) -> Bool {
        return lhs.id == rhs.id
    }
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}

// MARK: - Location
struct Location: Codable {
    let name: String?
    let url: String?
}

enum Status: String, Codable {
    case alive = "Alive"
    case dead = "Dead"
    case unknown = "unknown"
}
