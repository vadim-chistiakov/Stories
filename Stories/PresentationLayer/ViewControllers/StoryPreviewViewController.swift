//
//  StoryPreviewViewController.swift
//  Stories
//
//  Created by Чистяков Вадим Евгеньевич on 25/05/2019.
//  Copyright © 2019 ChistProduction. All rights reserved.
//


import UIKit

final class StoryPreviewViewController: UIViewController, CircleTransitionable {

    @IBOutlet private weak var collectionView: UICollectionView!

    var viewModel: StoryPreviewViewModel!
    private var didLayoutSubviewsOnce: Bool = false

    override var prefersStatusBarHidden: Bool {
        return true
    }

    var triggerCell: UICollectionViewCell?
    var mainView: UIView {
        return view
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        guard !didLayoutSubviewsOnce else { return }
        scrollToStory(atIndex: viewModel.currentStoryIndex.value, animated: false)
        didLayoutSubviewsOnce = true
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        bindViewModel()
    }

    private func configure() {
        collectionView.decelerationRate = .fast
        collectionView.registerNib(for: StoryCollectionViewCell.self)
    }

    private func bindViewModel() {
        viewModel.currentStoryIndex.bind { [weak self] index in
            self?.scrollToStory(atIndex: index, animated: true)
        }
        viewModel.action.bind { [weak self] in
            guard let action = $0 else { return }
            switch action {
            case .reload:
                self?.collectionView.reloadData()
            }
        }
    }

    private func scrollToStory(atIndex index: Int, animated: Bool) {
        collectionView.scrollToItem(at: IndexPath(row: index, section: 0),
                                    at: .centeredHorizontally,
                                    animated: animated)
    }

}

extension StoryPreviewViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.numberOfItems
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return collectionView.dequeueCell(with: StoryCollectionViewCell.self, for: indexPath)
    }

    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        guard let cellViewModel = viewModel.viewModelForItem(atIndex: indexPath.row),
            let storyCell = cell as? StoryCollectionViewCell else { return }
        storyCell.configure(with: cellViewModel)
    }

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        return collectionView.bounds.size
    }
}
