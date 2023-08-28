//
//  RMEndpoint.swift
//  RickAndMorty
//
//  Created by Андрей Королев on 19.08.2023.
//

import Foundation

@frozen enum RMEndpoint: String, Hashable, CaseIterable {
    case character // "character"
    case location
    case episode
}
