//
//  RickAndMortyModel.swift
//  ReactiveStatefulMVVM
//
//  Created by Barış ŞARALDI on 26.09.2022.
//

import Foundation

// MARK: - Characters
struct Characters: Codable,Hashable {
    let info: Info?
    let results: [Result]?
    
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
}

// MARK: - Result
struct Result: Codable,Hashable {
    let id: Int?
    let name: String?
    let status: Status?
    let species: Species?
    let type: String?
    let gender: Gender?
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

enum Gender: String, Codable {
    case female = "Female"
    case male = "Male"
    case unknown = "unknown"
}

// MARK: - Location
struct Location: Codable {
    let name: String?
    let url: String?
}

enum Species: String, Codable {
    case alien = "Alien"
    case human = "Human"
}

enum Status: String, Codable {
    case alive = "Alive"
    case dead = "Dead"
    case unknown = "unknown"
}
