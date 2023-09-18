//
//  RMSettingsOption.swift
//  RickAndMorty
//
//  Created by Андрей Королев on 18.09.2023.
//

import Foundation
import UIKit

enum RMSettingsOption: CaseIterable {
    case rateApp
    case contactUs
    case terms
    case privacy
    case apiReference
    case viewSeries
    case viewCode
    
    var targetUrl: URL? {
        switch self {
        case .rateApp:
            return nil
        case .contactUs:
            return URL(string: "https://yandex.ru")
        case .terms:
            return URL(string: "https://yandex.ru")
        case .privacy:
            return URL(string: "https://yandex.ru")
        case .apiReference:
            return URL(string: "https://rickandmortyapi.com/")
        case .viewSeries:
            return URL(string: "https://www.youtube.com/watch?v=gDjMZvYWUdo")
        case .viewCode:
            return URL(string: "https://github.com/nvl0451/RickAndMorty")
        }
    }
    
    var displayTitle: String {
        switch self {
        case .rateApp:
            return "Rate App"
        case .contactUs:
            return "Contact Us"
        case .terms:
            return "Terms of Service"
        case .privacy:
            return "Privacy Policy"
        case .apiReference:
            return "API Reference"
        case .viewSeries:
            return "View the Video Series"
        case .viewCode:
            return "Rate App"
        }
    }
    
    var iconContainerColor: UIColor {
        switch self {
        case .rateApp:
            return .systemCyan
        case .contactUs:
            return .systemRed
        case .terms:
            return .systemBlue
        case .privacy:
            return .systemMint
        case .apiReference:
            return .systemTeal
        case .viewSeries:
            return .systemIndigo
        case .viewCode:
            return .systemOrange
        }
    }
    
    var iconImage: UIImage? {
        switch self {
        case .rateApp:
            return UIImage(systemName: "star.fill")
        case .contactUs:
            return UIImage(systemName: "paperplane")
        case .terms:
            return UIImage(systemName: "doc")
        case .privacy:
            return UIImage(systemName: "lock")
        case .apiReference:
            return UIImage(systemName: "list.bullet")
        case .viewSeries:
            return UIImage(systemName: "tv.fill")
        case .viewCode:
            return UIImage(systemName: "hammer.fill")
        }
    }
}
