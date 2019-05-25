//
//  StoryCollectionViewCell.swift
//  Stories
//
//  Created by Чистяков Вадим Евгеньевич on 25/05/2019.
//  Copyright © 2019 ChistProduction. All rights reserved.
//


import UIKit
import SDWebImage

final class StoryCollectionViewCell: UICollectionViewCell, ConfigurableView {

    private struct Constants {
        static let minimumPressDuration: TimeInterval = 0.2
    }

    @IBOutlet private weak var progressBar: StoryProgressBar!
    @IBOutlet private weak var topGradientView: StoryGradientView!
    @IBOutlet private weak var bottomGradientView: StoryGradientView!
    @IBOutlet private weak var imageView: UIImageView!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var descriptionLabel: UILabel!
    @IBOutlet private var progressBarTopConstraint: NSLayoutConstraint!

    private var viewModel: StoryCellViewModel? {
        willSet {
            disposal.removeAll()
        }
    }

    private var disposal = Disposal()

    override func awakeFromNib() {
        super.awakeFromNib()
        configureGestures()
    }

    override func safeAreaInsetsDidChange() {
        if #available(iOS 11.0, *) {
            super.safeAreaInsetsDidChange()
            progressBarTopConstraint.isActive = false
            progressBar.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor).isActive = true
        }
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        viewModel = nil
    }

    func configure(with viewModel: StoryCellViewModel) {
        self.viewModel = viewModel
        progressBar.viewModel = viewModel.progressBarViewModel
        topGradientView.configureForTopView()
        bottomGradientView.configureForBottomView()

        viewModel.currentPage.observe { [weak self] in
            self?.configure(for: $0)
        }.add(to: &disposal)
    }

    private func configure(for page: StoryPage?) {
        guard let page = page else { return }
        titleLabel.text = page.title
        descriptionLabel.text = page.description
        imageView.sd_setImage(with: page.imageURL) { [weak self] (_, _, _, _)  in
            self?.viewModel?.start()
        }
    }

    private func configureGestures() {
        addTapGestureRecognizer(target: self, action: #selector(didTapOnPage))
        let longPressGesture = UILongPressGestureRecognizer(target: self, action: #selector(didLongPress))
        longPressGesture.minimumPressDuration = Constants.minimumPressDuration
        addGestureRecognizer(longPressGesture)

        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(didSwipeStory))
        swipeLeft.direction = .left
        addGestureRecognizer(swipeLeft)

        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(didSwipeStory))
        swipeRight.direction = .right
        addGestureRecognizer(swipeRight)
    }

    @IBAction private func closeStory() {
        viewModel?.close()
    }

    @objc private func didTapOnPage(_ sender: UITapGestureRecognizer) {
        viewModel?.stop()

        let tapLocation = sender.location(in: self)
        guard tapLocation.x > bounds.midX / 2 else {
            viewModel?.reset()
            return
        }
        viewModel?.changeStoryPage(to: .next)
    }

    @objc private func didLongPress(_ sender: UILongPressGestureRecognizer) {
        switch sender.state {
        case .began:
            viewModel?.pause()
        case .ended:
            viewModel?.resume()
        default:
            return
        }
    }

    @objc private func didSwipeStory(_ sender: UISwipeGestureRecognizer) {
        viewModel?.reset()
        switch sender.direction {
        case .right:
            viewModel?.changeStory(to: .previous)
        case .left:
            viewModel?.changeStory(to: .next)
        default:
            return
        }
    }

}
