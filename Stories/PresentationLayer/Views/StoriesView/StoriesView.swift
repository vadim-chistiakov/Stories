//
//  StoriesView.swift
//  Stories
//
//  Created by Чистяков Вадим Евгеньевич on 25/05/2019.
//  Copyright © 2019 ChistProduction. All rights reserved.
//


import UIKit

protocol StoriesViewDelegate: class {
    func storiesView(_ view: StoriesView, didSelectCell cell: UICollectionViewCell)
}

final class StoriesView: UIView {

    private struct Constants {
        static let itemSize: CGSize = CGSize(width: 80, height: 108)
        static let minimumLineSpacing: CGFloat = 8
        static let numberOfItemsForTempleteCells = 5
    }

    var viewModel: StoriesViewModel! {
        didSet {
            bindViewModel()
        }
    }

    weak var delegate: StoriesViewDelegate?

    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = Constants.minimumLineSpacing
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.isUserInteractionEnabled = false
        collectionView.backgroundColor = .clear
        return collectionView
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        configure()
    }

    private func configure() {
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.registerNib(for: StoryIconCollectionViewCell.self)
        addSubview(collectionView)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        addFrameEqualityConstraints(to: collectionView)
    }

    private func bindViewModel() {
        viewModel.action.bind { [weak self] in
            guard let action = $0 else { return }
            switch action {
            case .reload:
                self?.collectionView.reloadData()
                self?.collectionView.isUserInteractionEnabled = true
            }
        }
    }

}

extension StoriesView: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.numberOfItems != 0 ? viewModel.numberOfItems : Constants.numberOfItemsForTempleteCells
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cellViewModel = viewModel.viewModelForItem(atIndex: indexPath.row) else {
            return collectionView.dequeueCell(with: StoryIconCollectionViewCell.self, for: indexPath)
        }
        return collectionView.dequeue(StoryIconCollectionViewCell.self, at: indexPath, with: cellViewModel)
    }

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        return Constants.itemSize
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let cell = collectionView.cellForItem(at: indexPath) else { return }
        delegate?.storiesView(self, didSelectCell: cell)
        viewModel.selectStory(atIndex: indexPath.row)
    }
}
