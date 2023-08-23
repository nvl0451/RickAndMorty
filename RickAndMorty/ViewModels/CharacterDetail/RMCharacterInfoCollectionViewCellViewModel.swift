//
//  RMCharacterInfoCollectionViewCellViewModel.swift
//  RickAndMorty
//
//  Created by Андрей Королев on 23.08.2023.
//

import Foundation

final class RMCharacterInfoCollectionViewCellViewModel {
    private let value: String
    private let title: String
    
    init(
        value: String,
        title: String
    ) {
        self.value = value
        self.title = title
    }
}
