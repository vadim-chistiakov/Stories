//
//  StoryProgressBar.swift
//  Stories
//
//  Created by Чистяков Вадим Евгеньевич on 25/05/2019.
//  Copyright © 2019 ChistProduction. All rights reserved.
//


import UIKit

final class StoryProgressBar: UIView {

    private struct Constants {
        static let padding: CGFloat = 4
        static let height: CGFloat = 2
        static let yPoint: CGFloat = 0
        static let cornerRadius: CGFloat = 2.5
        static let placeholderAlpha: CGFloat = 0.4
        static let screenWidth: CGFloat = UIScreen.main.bounds.width
    }

    var viewModel: StoryProgressBarViewModel! {
        didSet {
            createPageIndicators()
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }


    private func createPageIndicators() {
        subviews.forEach { view in view.removeFromSuperview() }
        var xPoint: CGFloat = Constants.padding * 2
        let width = (Constants.screenWidth - (CGFloat(viewModel.pagesCount - 1) * Constants.padding) - 2 * xPoint)/CGFloat(viewModel.pagesCount)
        for index in 0..<viewModel.pagesCount {
            let pageIndicatorPlaceholder = UIView(frame: CGRect(x: xPoint, y: Constants.yPoint, width: width, height: Constants.height))
            let pageIndicator = StoryPageProgressView(frame: CGRect(x: xPoint, y: Constants.yPoint, width: 0, height: Constants.height))
            pageIndicator.viewModel = viewModel.viewModels[index]
            pageIndicator.width = width
            addSubview(applyProperties(pageIndicatorPlaceholder, alpha: Constants.placeholderAlpha))
            addSubview(applyProperties(pageIndicator))
            xPoint += width + Constants.padding
        }
    }

    private func applyProperties(_ view: UIView, alpha: CGFloat = 1.0) -> UIView {
        view.layer.cornerRadius = Constants.cornerRadius
        view.layer.masksToBounds = true
        view.backgroundColor = UIColor.white.withAlphaComponent(alpha)
        return view
    }

}
