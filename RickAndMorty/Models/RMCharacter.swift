//
//  RMCharacter.swift
//  RickAndMorty
//
//  Created by Андрей Королев on 19.08.2023.
//

import Foundation

struct RMCharacter: Codable {
    let id: Int
    let name: String
    let status: RMCharacterStatus
    let species: String
    let type: String
    let gender: RMCharacterGender
    let origin: RMOrigin
    let location: RMSingleLocation
    let image: String
    let episode: [String]
    let url: String
    let created: String
}

enum RMCharacterStatus: String, Codable {
    case alive = "Alive"
    case dead = "Dead"
    case unknown = "unknown"
}

enum RMCharacterGender: String, Codable {
    case male = "Alive"
    case female = "Dead"
    case genderless = "Genderless"
    case unknown = "unknown"
}
