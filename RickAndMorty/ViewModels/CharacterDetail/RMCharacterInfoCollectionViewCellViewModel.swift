//
//  RMCharacterInfoCollectionViewCellViewModel.swift
//  RickAndMorty
//
//  Created by Андрей Королев on 23.08.2023.
//

import Foundation
import UIKit

final class RMCharacterInfoCollectionViewCellViewModel {
    private let type: CharType
    private let value: String
    
    static let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        formatter.timeZone = .current
        return formatter
    }()
    
    static let shortDateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .short
        return formatter
    }()
    
    
    public var title: String {
        self.type.displayTitle
    }
    
    public var displayValue: String {
        if value.isEmpty { return "None" }
        
        if type == .created {
            guard let date = Self.dateFormatter.date(from: value) else {
                return "Bad date"
            }
            
            return Self.shortDateFormatter.string(from: date)
        }
        
        return value
    }
    
    public var iconImage: UIImage? {
        return self.type.iconImage
    }
    
    public var iconTint: UIColor {
        return self.type.tintColor
    }
    
    enum CharType {
        case status
        case gender
        case type
        case species
        case origin
        case created
        case location
        case episodeCount
        
        var tintColor: UIColor {
            switch self {
            case .status:
                return .systemBlue
            case .gender:
                return .systemRed
            case .type:
                return .systemPurple
            case .species:
                return .systemGreen
            case .origin:
                return .systemOrange
            case .created:
                return .systemPink
            case .location:
                return .systemYellow
            case .episodeCount:
                return .systemMint
            }
        }
        
        var iconImage: UIImage? {
            switch self {
            case .status:
                return UIImage(systemName: "bell")
            case .gender:
                return UIImage(systemName: "bell")
            case .type:
                return UIImage(systemName: "bell")
            case .species:
                return UIImage(systemName: "bell")
            case .origin:
                return UIImage(systemName: "bell")
            case .created:
                return UIImage(systemName: "bell")
            case .location:
                return UIImage(systemName: "bell")
            case .episodeCount:
                return UIImage(systemName: "bell")
            }
        }
        
        var displayTitle: String {
            switch self {
            case .status:
                return "Status"
            case .gender:
                return "Gender"
            case .type:
                return "Type"
            case .species:
                return "Species"
            case .origin:
                return "Origin"
            case .created:
                return "Created"
            case .location:
                return "Location"
            case .episodeCount:
                return "Episode Count"
            }
        }
    }
    
    init(
        type: CharType,
        value: String
    ) {
        self.value = value
        self.type = type
    }
}
