//
//  BaseStoryProgressBarViewModel.swift
//  Stories
//
//  Created by Чистяков Вадим Евгеньевич on 25/05/2019.
//  Copyright © 2019 ChistProduction. All rights reserved.
//



final class BaseStoryProgressBarViewModel: StoryProgressBarViewModel {

    var pagesCount: Int
    var viewModels: [StoryPageProgressViewModel] = []
    weak var delegate: StoryProgressBarViewModelDelegate?

    init(pagesCount: Int) {
        self.pagesCount = pagesCount
        generateViewModels()
    }

    func start(forIndex index: Int) {
        viewModels[index].action.value = .start
    }

    func pause(forIndex index: Int) {
        viewModels[index].action.value = .pause
    }

    func resume(forIndex index: Int) {
        viewModels[index].action.value = .resume
    }

    func stop(forIndex index: Int) {
        viewModels[index].action.value = .stop
    }

    func reset(forIndex index: Int) {
        viewModels[index - 1].action.value = .reset
        viewModels[index].action.value = .reset
    }

    func generateViewModels() {
        viewModels.removeAll()
        for _ in 0..<pagesCount {
            viewModels.append(StoryPageProgressViewModel(delegate: self))
        }
    }

}

extension BaseStoryProgressBarViewModel: StoryPageProgressViewModelDelegate {
    func storyPageProgressViewModelDidFinishAnimation(_ viewModel: StoryPageProgressViewModel) {
        delegate?.storyProgressBarViewModelDidFinishAnimation(self)
    }
}
