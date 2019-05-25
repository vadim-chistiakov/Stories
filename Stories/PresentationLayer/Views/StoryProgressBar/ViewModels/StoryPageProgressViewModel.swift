//
//  StoryPageProgressViewModel.swift
//  Stories
//
//  Created by Чистяков Вадим Евгеньевич on 25/05/2019.
//  Copyright © 2019 ChistProduction. All rights reserved.
//


enum StoryPageProgressViewModelAction {
    case start
    case pause
    case resume
    case stop
    case reset
}

protocol StoryPageProgressViewModelDelegate: class {
    func storyPageProgressViewModelDidFinishAnimation(_ viewModel: StoryPageProgressViewModel)
}

final class StoryPageProgressViewModel {

    let action: Observable<StoryPageProgressViewModelAction?> = Observable(nil)
    private weak var delegate: StoryPageProgressViewModelDelegate?

    init(delegate: StoryPageProgressViewModelDelegate?) {
        self.delegate = delegate
    }

    func finish() {
        delegate?.storyPageProgressViewModelDidFinishAnimation(self)
    }
}
