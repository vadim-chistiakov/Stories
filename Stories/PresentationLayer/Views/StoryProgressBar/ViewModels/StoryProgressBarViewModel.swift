//
//  StoryProgressBarViewModel.swift
//  Stories
//
//  Created by Чистяков Вадим Евгеньевич on 25/05/2019.
//  Copyright © 2019 ChistProduction. All rights reserved.
//


protocol StoryProgressBarViewModelDelegate: class {
    func storyProgressBarViewModelDidFinishAnimation(_ viewModel: StoryProgressBarViewModel)
}

protocol StoryProgressBarViewModel: class {

    typealias Completion = () -> Void
    var pagesCount: Int { get }
    var viewModels: [StoryPageProgressViewModel] { get }
    var delegate: StoryProgressBarViewModelDelegate? { get set }

    func start(forIndex index: Int)
    func pause(forIndex index: Int)
    func resume(forIndex index: Int)
    func stop(forIndex index: Int)
    func reset(forIndex index: Int)

}
