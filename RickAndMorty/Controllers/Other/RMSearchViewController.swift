//
//  RMSearchViewController.swift
//  RickAndMorty
//
//  Created by Андрей Королев on 17.09.2023.
//

import UIKit

class RMSearchViewController: UIViewController {
    
    struct Config {
        enum searchType {
            case character
            case location
            case episode
        }
        let type: searchType
    }
    
    private let config: Config
    
    init(config: Config) {
        self.config = config
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("STFU")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Search"
        view.backgroundColor = .systemBackground
    }
}
