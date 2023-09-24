//
//  RMEpisodeInfoCollectionViewCell.swift
//  RickAndMorty
//
//  Created by Андрей Королев on 18.09.2023.
//

import UIKit

protocol RMEpisodeInfoCollectionWatchButtonViewCellDelegate: AnyObject {
    func rmEpisodeWatchButton(_ watchButton: RMEpisodeInfoCollectionWatchButtonViewCell, episodeCode: String)
}

class RMEpisodeInfoCollectionWatchButtonViewCell: UICollectionViewCell {
    
    static let cellIdentifier = "RMEpisodeInfoCollectionWatchButtonViewCell"
    
    private var viewModel: RMEpisodeInfoCollectionWatchButtonViewCellViewModel?
    
    public weak var delegate: RMEpisodeInfoCollectionWatchButtonViewCellDelegate?
    
    private let gradientButton: ActualGradientButton = {
        let green1 = UIColor(red: 0.36, green: 0.68, blue: 0.29, alpha: 1.00).cgColor
        let green2 = UIColor(red: 0.13, green: 0.55, blue: 0.27, alpha: 1.00).cgColor
        let green3 = UIColor(red: 0.65, green: 0.80, blue: 0.33, alpha: 1.00).cgColor
        
        let button = ActualGradientButton(frame: .zero, colors: [green1, green2, green3])
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("watch episode", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 33, weight: .regular)
        button.setTitleColor(UIColor.black, for: .normal)
        button.isExclusiveTouch = false
        button.addTarget(self, action: #selector(didTapWatch), for: .touchUpInside)
        return button
    }()
    
    @objc
    private func didTapWatch() {
        delegate?.rmEpisodeWatchButton(self, episodeCode: viewModel?.episodeCode ?? "")
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = .secondarySystemBackground
        contentView.addSubviews(gradientButton)
        setupLayer()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
    
    private func setupLayer() {
        layer.cornerRadius = 8
        layer.masksToBounds = true
        layer.borderWidth = 1
        layer.borderColor = UIColor.secondaryLabel.cgColor
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            gradientButton.topAnchor.constraint(equalTo: contentView.topAnchor),
            gradientButton.leftAnchor.constraint(equalTo: contentView.leftAnchor),
            gradientButton.rightAnchor.constraint(equalTo: contentView.rightAnchor),
            gradientButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
        ])
    }
    
    func configure(with viewModel: RMEpisodeInfoCollectionWatchButtonViewCellViewModel) {
        self.viewModel = viewModel
    }
}
