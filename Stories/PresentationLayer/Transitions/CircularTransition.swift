//
//  CircularTransition.swift
//  Stories
//
//  Created by Чистяков Вадим Евгеньевич on 25/05/2019.
//  Copyright © 2019 ChistProduction. All rights reserved.
//


import UIKit

protocol CircleTransitionable {
    var triggerCell: UICollectionViewCell? { get }
    var contentView: UIView? { get }
    var mainView: UIView { get }
}

extension CircleTransitionable {
    var triggerCell: UICollectionViewCell? {
        return nil
    }
    var contentView: UIView? {
        return nil
    }
}

final class CircularTransition: NSObject, UIViewControllerAnimatedTransitioning {

    weak var context: UIViewControllerContextTransitioning?
    var containerView: UIView?

    var triggerCell: UICollectionViewCell?
    var contentView: UIView?
    var snapshot: UIView?

    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 1
    }

    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        guard let fromVC = transitionContext.viewController(forKey: .from) as? CircleTransitionable,
            let toVC = transitionContext.viewController(forKey: .to) as? CircleTransitionable,
            let snapshot = fromVC.mainView.snapshotView(afterScreenUpdates: false) else {
                transitionContext.completeTransition(false)
                return
        }

        if fromVC.triggerCell != nil, fromVC.contentView != nil {
            triggerCell = fromVC.triggerCell
            contentView = fromVC.contentView
        }
        if self.snapshot == nil {
            self.snapshot = snapshot
        }

        context = transitionContext
        let containerView = transitionContext.containerView

        if fromVC.triggerCell != nil {
            containerView.addSubview(snapshot)
            fromVC.mainView.removeFromSuperview()
            containerView.addSubview(toVC.mainView)
            self.containerView = containerView

            animatePush(toView: toVC.mainView)
        } else {
            containerView.addSubview(toVC.mainView)
            fromVC.mainView.removeFromSuperview()
            containerView.addSubview(fromVC.mainView)
            self.containerView = containerView

            animatePop(fromVC: fromVC.mainView)
        }

    }

    private func animatePop(fromVC: UIView) {
        guard let cell = triggerCell, let contextView = self.contentView else { return }
        let circleMaskPathInitial = UIBezierPath(rect: fromVC.frame)

        let rect = CGRect(x: cell.frame.origin.x + contextView.frame.origin.x,
                          y: cell.frame.origin.y + contextView.frame.origin.y,
                          width: cell.frame.width,
                          height: cell.frame.height)
        let circleMaskPathFinal = UIBezierPath(rect: rect)

        let maskLayer = CAShapeLayer()
        maskLayer.path = circleMaskPathFinal.cgPath
        fromVC.layer.mask = maskLayer

        let maskLayerAnimation = CABasicAnimation(keyPath: "path")
        maskLayerAnimation.fromValue = circleMaskPathInitial.cgPath
        maskLayerAnimation.toValue = circleMaskPathFinal.cgPath
        maskLayerAnimation.duration = 0.3
        maskLayerAnimation.delegate = self
        maskLayer.add(maskLayerAnimation, forKey: "path")
    }

    private func animatePush(toView: UIView) {
        guard let cell = triggerCell, let contextView = self.contentView else { return }
        let rect = CGRect(x: cell.frame.origin.x + contextView.frame.origin.x,
                          y: cell.frame.origin.y + contextView.frame.origin.y,
                          width: cell.frame.width,
                          height: cell.frame.height)
        let circleMaskPathInitial = UIBezierPath(rect: rect)

        let circleMaskPathFinal = UIBezierPath(rect: toView.frame)
        let maskLayer = CAShapeLayer()
        maskLayer.path = circleMaskPathFinal.cgPath
        toView.layer.mask = maskLayer

        let maskLayerAnimation = CABasicAnimation(keyPath: "path")
        maskLayerAnimation.fromValue = circleMaskPathInitial.cgPath
        maskLayerAnimation.toValue = circleMaskPathFinal.cgPath
        maskLayerAnimation.duration = 0.3
        maskLayerAnimation.delegate = self
        maskLayer.add(maskLayerAnimation, forKey: "path")
    }

}

extension CircularTransition: CAAnimationDelegate {
    func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
        context?.completeTransition(true)
    }
}
