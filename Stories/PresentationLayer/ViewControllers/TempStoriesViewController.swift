//
//  TempStoriesViewController.swift
//  Stories
//
//  Created by Чистяков Вадим Евгеньевич on 25/05/2019.
//  Copyright © 2019 ChistProduction. All rights reserved.
//


import UIKit

final class TempStoriesViewController: UIViewController, CircleTransitionable {

    var router: StoriesRouter!
    var triggerCell: UICollectionViewCell?
    var contentView: UIView? {
        return view.subviews.first
    }
    var mainView: UIView {
        return view
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        let viewModel = BaseStoriesViewModel(service: BaseStoriesService(mapper: BaseStoriesMapper()),
                                             router: router)
        let storiesView = StoriesView(frame: CGRect(x: 0, y: 64, width: view.frame.size.width, height: 108))
        storiesView.viewModel = viewModel
        storiesView.delegate = self
        view.addSubview(storiesView)
    }

}

extension TempStoriesViewController: StoriesViewDelegate {
    func storiesView(_ view: StoriesView, didSelectCell cell: UICollectionViewCell) {
        triggerCell = cell
    }
}
