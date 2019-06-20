//
//  BaseStoriesRouter.swift
//  Stories
//
//  Created by Чистяков Вадим Евгеньевич on 25/05/2019.
//  Copyright © 2019 ChistProduction. All rights reserved.
//


import UIKit

final class BaseStoriesRouter: StoriesRouter {

    private var navigationController: UINavigationController?
    private let transitionCoordinator = TransitionCoordinator(circularTransition: CircularTransition())

    func route(to route: StoriesRoute) {
        switch route {
        case .dismiss:
            navigationController?.popViewController(animated: true)
        case .showStoryPreview(let viewModels, let index):
            showStoryPreview(with: viewModels, startIndex: index)
        }
    }

    func getConfiguredRootViewController() -> UIViewController {
        if let rootViewController = self.navigationController { return rootViewController }
        let viewController = TempStoriesViewController()
        viewController.router = self

        let navigationController = UINavigationController(rootViewController: viewController)
        navigationController.isNavigationBarHidden = true
        self.navigationController = navigationController
        return navigationController
    }

    private func showStoryPreview(with viewModels: [StoryCellViewModel], startIndex index: Int) {
        guard let navigationController = self.navigationController else { return }

        let storyPreviewStoryboard = UIStoryboard.init(name: "Stories", bundle: nil)
        guard let viewController = storyPreviewStoryboard.instantiateViewController(withIdentifier: "StoryPreviewViewController") as? StoryPreviewViewController else { return }
        viewController.viewModel = BaseStoryPreviewViewModel(router: self,
                                                             viewModels: viewModels,
                                                             startIndex: index)
        navigationController.delegate = transitionCoordinator
        navigationController.pushViewController(viewController, animated: true)
    }

}
