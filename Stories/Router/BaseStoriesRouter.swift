//
//  BaseStoriesRouter.swift
//  Stories
//
//  Created by Чистяков Вадим Евгеньевич on 25/05/2019.
//  Copyright © 2019 ChistProduction. All rights reserved.
//


import UIKit

final class BaseStoriesRouter: StoriesRouter {

    private weak var navigationController: UINavigationController?
    private var transitionCoordinator: TransitionCoordinator {
        return TransitionCoordinator(circularTransition: CircularTransition())
    }

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

        let navigationController = UINavigationController(rootViewController: viewController)
        navigationController.isNavigationBarHidden = true
        navigationController.delegate = transitionCoordinator
        self.navigationController = navigationController
        return navigationController
    }

    private func showStoryPreview(with viewModels: [StoryCellViewModel], startIndex index: Int) {
        guard let navigationController = self.navigationController else { return }

        let viewController = StoryPreviewViewController()
        viewController.viewModel = BaseStoryPreviewViewModel(router: self,
                                                             viewModels: viewModels,
                                                             startIndex: index)

        navigationController.pushViewController(viewController, animated: true)
    }

}
