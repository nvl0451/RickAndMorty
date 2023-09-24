//
//  RMTableLoadingFooterView.swift
//  RickAndMorty
//
//  Created by Андрей Королев on 21.09.2023.
//

import UIKit

final class RMTableLoadingFooterView: UIView {
    
    private let spinner: UIActivityIndicatorView = {
        let spinner = UIActivityIndicatorView()
        spinner.translatesAutoresizingMaskIntoConstraints = false
        spinner.hidesWhenStopped = true
        return spinner
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        //translatesAutoresizingMaskIntoConstraints = false
        addSubviews(spinner)
        spinner.startAnimating()
        
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            spinner.centerXAnchor.constraint(equalTo: centerXAnchor),
            spinner.centerYAnchor.constraint(equalTo: centerYAnchor),
            spinner.widthAnchor.constraint(equalToConstant: 100),
            spinner.heightAnchor.constraint(equalToConstant: 100)
        ])
    }
    
}
