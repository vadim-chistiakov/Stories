//
//  StoriesRouter.swift
//  Stories
//
//  Created by Чистяков Вадим Евгеньевич on 25/05/2019.
//  Copyright © 2019 ChistProduction. All rights reserved.
//


import UIKit

enum StoriesRoute {
    case dismiss
    case showStoryPreview([StoryCellViewModel], Int)
}

protocol StoriesRouter: class {
    func route(to route: StoriesRoute)
    func getConfiguredRootViewController() -> UIViewController
}
