//
//  StoryGradientView.swift
//  Stories
//
//  Created by Чистяков Вадим Евгеньевич on 25/05/2019.
//  Copyright © 2019 ChistProduction. All rights reserved.
//


import UIKit

final class StoryGradientView: UIView {

    private struct Constants {
        static let bottomGradientColors: [CGColor] = [UIColor.clear.cgColor,
                                                      UIColor.clear.withAlphaComponent(0.52).cgColor,
                                                      UIColor.clear.withAlphaComponent(0.50).cgColor]
        static let bottomGradientLocations: [NSNumber] = [0.0, 0.63, 1.0]
        static let topGradientColors: [CGColor] = [UIColor.clear.withAlphaComponent(0.35).cgColor,
                                                   UIColor.clear.withAlphaComponent(0.35).cgColor,
                                                   UIColor.clear.cgColor]
        static let topGradientLocations: [NSNumber] = [0.0, 0.26, 1.0]
    }

    private let gradient = CAGradientLayer()

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure(with: gradient)
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        configure(with: gradient)
    }

    override func layoutSublayers(of layer: CALayer) {
        super.layoutSublayers(of: layer)
        gradient.frame = bounds
    }

    func configureForBottomView() {
        gradient.colors = Constants.bottomGradientColors
        gradient.locations = Constants.bottomGradientLocations
    }

    func configureForTopView() {
        gradient.colors = Constants.topGradientColors
        gradient.locations = Constants.topGradientLocations
    }

    private func configure(with gradient: CAGradientLayer) {
        layer.insertSublayer(gradient, at: 0)
    }

}
