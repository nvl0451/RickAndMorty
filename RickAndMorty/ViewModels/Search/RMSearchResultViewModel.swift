//
//  RMSearchResultsViewModel.swift
//  RickAndMorty
//
//  Created by Андрей Королев on 20.09.2023.
//

import Foundation

enum RMSearchResultViewModel {
    case characters([RMCharacterCollectionViewCellViewModel])
    case episodes([RMCharacterEpisodeCollectionViewCellViewModel])
    case locations([RMLocationTableViewCellViewModel])
}
