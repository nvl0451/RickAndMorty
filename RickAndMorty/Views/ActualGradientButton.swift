//
//  ActualGradientButton.swift
//  RickAndMorty
//
//  Created by Андрей Королев on 23.09.2023.
//

import UIKit


final class ActualGradientButton: UIButton {

    override func layoutSubviews() {
        super.layoutSubviews()
        gradientLayer.frame = bounds
    }
    
    init(frame: CGRect, colors: [CGColor]?) {
        super.init(frame: frame)
        if let colors = colors {
            gradientLayer.colors = colors
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private lazy var gradientLayer: CAGradientLayer = {
        let l = CAGradientLayer()
        l.frame = self.bounds
        l.colors = [UIColor.systemBlue.cgColor, UIColor.systemPurple.cgColor, UIColor.systemCyan.cgColor]
        l.startPoint = CGPoint(x: 0, y: 0.5)
        l.endPoint = CGPoint(x: 1, y: 0.5)
        l.locations = [0.0, 0.5, 1.0]
        l.cornerRadius = 8
        l.add(gradientAnimation, forKey: gradientAnimation.keyPath)
        layer.insertSublayer(l, at: 0)
        return l
    }()
    
    private lazy var gradientAnimation: CABasicAnimation = {
        let anim = CABasicAnimation(keyPath: "locations")
        anim.fromValue = [-0.5, 0.25, 0.5]
        anim.toValue = [0.5, 0.75, 1.5]
        anim.autoreverses = true
        anim.repeatCount = .infinity
        anim.duration = 8
        return anim
    }()
}
