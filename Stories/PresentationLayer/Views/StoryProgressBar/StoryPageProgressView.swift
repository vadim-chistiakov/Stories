//
//  StoryPageProgressView.swift
//  Stories
//
//  Created by Чистяков Вадим Евгеньевич on 25/05/2019.
//  Copyright © 2019 ChistProduction. All rights reserved.
//


import UIKit

final class StoryPageProgressView: UIView {

    var width: CGFloat = 0
    var viewModel: StoryPageProgressViewModel! {
        didSet {
            bindViewModel()
        }
        willSet {
            disposal.removeAll()
        }
    }
    private var disposal = Disposal()

    private struct Constants {
        static let duration: TimeInterval = 12
    }

    private func bindViewModel() {
        viewModel.action.observe { [weak self] in
            guard let self = self, let action = $0 else { return }
            switch action {
            case .start:
                self.start()
            case .pause:
                self.pause()
            case .resume:
                self.resume()
            case .stop:
                self.stop()
            case .reset:
                self.reset()
            }
        }.add(to: &disposal)
    }


    private func start() {
        UIView.animate(withDuration: Constants.duration, delay: 0, options: .curveLinear, animations: { [weak self] in
            guard let self = self else { return }
            self.frame.size.width = self.width
        }, completion: { [weak self] finished in
            guard finished else { return }
            self?.viewModel.finish()
        })
    }

    private func pause() {
        let pausedTime = layer.convertTime(CACurrentMediaTime(), from: nil)
        layer.speed = 0.0
        layer.timeOffset = pausedTime
    }

    private func resume() {
        let pausedTime = layer.timeOffset
        layer.speed = 1.0
        layer.timeOffset = 0.0
        layer.beginTime = 0.0
        let timeSincePause = layer.convertTime(CACurrentMediaTime(), from: nil) - pausedTime
        layer.beginTime = timeSincePause
    }

    private func stop() {
        resume()
        layer.removeAllAnimations()
    }

    private func reset() {
        layer.removeAllAnimations()
        frame.size.width = 0
    }

}
