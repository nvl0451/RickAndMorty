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
            
            var endpoint: RMEndpoint {
                switch self {
                case .character:
                    return .character
                case .location:
                    return .location
                case .episode:
                    return .episode
                }
            }
            
            
            
            var title: String {
                switch self {
                case .character:
                    return "Search Characters"
                case .location:
                    return "Search Locations"
                case .episode:
                    return "Search Episodes"
                }
            }
        }
        let type: searchType
    }
    
    private let viewModel: RMSearchViewViewModel
    private let searchView: RMSearchView
    
    init(config: Config) {
        let viewModel = RMSearchViewViewModel(config: config)
        self.viewModel = viewModel
        self.searchView = RMSearchView(frame: .zero, viewModel: viewModel)
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = viewModel.config.type.title
        view.backgroundColor = .systemBackground
        view.addSubviews(searchView)
        setupConstraints()
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            title: "Search",
            style: .done,
            target: self,
            action: #selector(didTapExecuteSearch)
        )
        searchView.delegate = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        searchView.presentKeyboard()
    }
    
    @objc
    private func didTapExecuteSearch() {
        viewModel.executeSearch()
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            searchView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            searchView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            searchView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
            searchView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),
        ])
    }
}

extension RMSearchViewController: RMSearchViewDelegate {
    func rmSearchView(_ searchView: RMSearchView, didSelectOption: RMSearchInputViewViewModel.DynamicOption) {
        let vc = RMSearchOptionPickerViewController(option: didSelectOption) { [weak self] string in
            DispatchQueue.main.async {
                self?.viewModel.set(value: string, for: didSelectOption)
            }
        }
        vc.sheetPresentationController?.detents = [.medium()]
        vc.sheetPresentationController?.prefersGrabberVisible = true
        present(vc, animated: true)
    }
    
    func rmSearchView(_ searchView: RMSearchView, didSelectLocation: RMLocation) {
        let vc = RMLocationDetailViewController(location: didSelectLocation)
        navigationItem.largeTitleDisplayMode = .never
        navigationController?.pushViewController(vc, animated: true)
    }
}
