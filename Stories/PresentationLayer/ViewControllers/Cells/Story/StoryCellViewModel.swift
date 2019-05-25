//
//  StoryCellViewModel.swift
//  Stories
//
//  Created by Чистяков Вадим Евгеньевич on 25/05/2019.
//  Copyright © 2019 ChistProduction. All rights reserved.
//


import Foundation

enum StoryPreviewDirection {
    case next
    case previous
}

protocol StoryProgressBarAnimator: class {
    func start()
    func pause()
    func resume()
    func stop()
    func reset()
}

protocol StoryCellViewModelDelegate: class {
    func storyCellViewModelDidRequestClose(_ viewModel: StoryCellViewModel)
    func storyCellViewModel(_ viewModel: StoryCellViewModel, didChangeStoryWith direction: StoryPreviewDirection)
}

protocol StoryCellViewModel: NSCopying, StoryProgressBarAnimator {
    var currentPage: Observable<StoryPage?> { get }
    var currentPageIndex: Int? { get }
    var progressBarViewModel: StoryProgressBarViewModel { get }
    var delegate: StoryCellViewModelDelegate? { get set }

    func close()
    func changeStory(to direction: StoryPreviewDirection)
    func changeStoryPage(to direction: StoryPreviewDirection)
}
