//
//  RMEpisodeDetailViewController.swift
//  RickAndMorty
//
//  Created by Андрей Королев on 28.08.2023.
//

import UIKit

final class RMEpisodeDetailViewController: UIViewController {
    
    private let url: URL?
    
    init(url: URL?) {
        self.url = url
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("STFU")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Episode"
        view.backgroundColor = .systemBackground
        // Do any additional setup after loading the view.
    }
}
