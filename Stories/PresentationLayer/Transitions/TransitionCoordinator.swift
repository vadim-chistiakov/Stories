//
//  TransitionCoordinator.swift
//  Stories
//
//  Created by Чистяков Вадим Евгеньевич on 25/05/2019.
//  Copyright © 2019 ChistProduction. All rights reserved.
//


import UIKit

final class TransitionCoordinator: NSObject, UINavigationControllerDelegate {

    private let circularTransition: CircularTransition

    init(circularTransition: CircularTransition) {
        self.circularTransition = circularTransition
    }

    func navigationController(_ navigationController: UINavigationController,
                              animationControllerFor operation: UINavigationController.Operation,
                              from fromVC: UIViewController,
                              to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return circularTransition
    }
}
