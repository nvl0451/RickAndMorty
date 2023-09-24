//
//  RMStreamingViewController.swift
//  RickAndMorty
//
//  Created by Андрей Королев on 23.09.2023.
//

import UIKit
import AVKit

class RMStreamingViewController: UIViewController {
    
    private let backgroundImage: UIImageView = {
        let image = UIImage(named: "splash2")
        let imageView = UIImageView(image: image)
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let pickerView: UIPickerView = {
        let picker = UIPickerView()
        picker.translatesAutoresizingMaskIntoConstraints = false
        picker.setValue(UIColor.black, forKeyPath: "textColor")
        return picker
    }()
    
    private let alphaView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 8
        view.backgroundColor = .white
        view.alpha = 0.4
        return view
    }()
    
    private let gradientButton: ActualGradientButton = {
        let button = ActualGradientButton(frame: .zero, colors: nil)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("watch episode", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 33, weight: .regular)
        button.setTitleColor(UIColor.black, for: .normal)
        button.addTarget(self, action: #selector(didTapWatch), for: .touchUpInside)
        return button
    }()
    
    private let seasonLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "season"
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 28, weight: .regular)
        label.textColor = .black
        return label
    }()
    
    private let episodeLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "episode"
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 28, weight: .regular)
        label.textColor = .black
        return label
    }()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view.backgroundColor = .systemBackground
        pickerView.dataSource = self
        pickerView.delegate = self
        addSubviews()
        setupConstraints()
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .portrait
    }
    
    @objc
    private func didTapWatch() {
        let season = pickerView.selectedRow(inComponent: 0) + 1
        let episcode = pickerView.selectedRow(inComponent: 1) + 1
        Task {
            let url = await RMEpisodeUrlGetter.shared.getEpisodeDownloadUrl(season: season, episode: episcode)
            
            if let url = url {
                let player = AVPlayer(url: url)
                let vc = AVPlayerViewController()
                vc.player = player
                self.present(vc, animated: true) {
                    vc.player?.play()
                }
            }
        }
    }

    private func addSubviews() {
        view.addSubview(backgroundImage)
        view.addSubview(alphaView)
        view.addSubview(pickerView)
        view.addSubview(gradientButton)
        view.addSubview(seasonLabel)
        view.addSubview(episodeLabel)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            backgroundImage.topAnchor.constraint(equalTo: view.topAnchor),
            backgroundImage.leftAnchor.constraint(equalTo: view.leftAnchor),
            backgroundImage.rightAnchor.constraint(equalTo: view.rightAnchor),
            backgroundImage.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            
            alphaView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 5),
            alphaView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: 10),
            alphaView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: -10),
            alphaView.heightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.heightAnchor, multiplier: 0.5, constant: -6),
            
            gradientButton.bottomAnchor.constraint(equalTo: alphaView.bottomAnchor),
            gradientButton.leftAnchor.constraint(equalTo: alphaView.leftAnchor),
            gradientButton.rightAnchor.constraint(equalTo: alphaView.rightAnchor),
            gradientButton.heightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.heightAnchor, multiplier: 0.1),
            
            pickerView.topAnchor.constraint(equalTo: alphaView.topAnchor),
            pickerView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: 10),
            pickerView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: -10),
            pickerView.bottomAnchor.constraint(equalTo: gradientButton.topAnchor, constant: -3)
        ])
        
        let secondaryLabelWidth = (UIScreen.main.bounds.width - 20) / 2
        
        NSLayoutConstraint.activate([
            seasonLabel.leftAnchor.constraint(equalTo: alphaView.leftAnchor, constant: 5),
            seasonLabel.widthAnchor.constraint(equalToConstant: secondaryLabelWidth),
            seasonLabel.topAnchor.constraint(equalTo: alphaView.topAnchor, constant: 10),
            
            episodeLabel.rightAnchor.constraint(equalTo: alphaView.rightAnchor, constant: -5),
            episodeLabel.widthAnchor.constraint(equalToConstant: secondaryLabelWidth),
            episodeLabel.topAnchor.constraint(equalTo: alphaView.topAnchor, constant: 10),
        ])
    }
}

extension RMStreamingViewController: UIPickerViewDataSource, UIPickerViewDelegate {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 2
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if component == 0 {
            return 5
        } else {
            return 10
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView!) -> UIView {
        let pickerLabel = UILabel()
        pickerLabel.text = String(row + 1)
        pickerLabel.textColor = UIColor.black
        pickerLabel.font = .systemFont(ofSize: 30, weight: .bold)
        pickerLabel.textAlignment = NSTextAlignment.center
        return pickerLabel
    }
}
