//
//  RMSettingsCellViewViewModel.swift
//  RickAndMorty
//
//  Created by Андрей Королев on 18.09.2023.
//

import Foundation
import UIKit

struct RMSettingsCellViewModel: Identifiable {
    //image | title
    public let type: RMSettingsOption
    public let onTapHandler: (RMSettingsOption) -> Void
    
    let id = UUID()
    
    init(type: RMSettingsOption, onTapHandler: @escaping (RMSettingsOption) -> Void) {
        self.type = type
        self.onTapHandler = onTapHandler
    }
    
    public var image: UIImage? {
        return type.iconImage
    }
    public var title: String {
        return type.displayTitle
    }
    
    public var iconContainerColor: UIColor {
        return type.iconContainerColor
    }
}
