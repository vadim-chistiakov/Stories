//
//  BaseStoryPreviewViewModel.swift
//  Stories
//
//  Created by Чистяков Вадим Евгеньевич on 25/05/2019.
//  Copyright © 2019 ChistProduction. All rights reserved.
//


import Foundation.NSURL

final class BaseStoryPreviewViewModel: StoryPreviewViewModel {

    let currentStoryIndex: Observable<Int>
    let action: Observable<StoryPreviewViewModelAction?> = Dynamic(nil)
    var numberOfItems: Int { return viewModels.count }

    private let router: StoriesRouter
    private let viewModels: [StoryCellViewModel]

    init(router: StoriesRouter, viewModels: [StoryCellViewModel], startIndex: Int) {
        self.router = router
        self.viewModels = viewModels
        self.currentStoryIndex = Observable(startIndex)
    }

    func viewModelForItem(atIndex index: Int) -> StoryCellViewModel? {
        let itemViewModel = viewModels[index].copy() as? StoryCellViewModel
        itemViewModel?.delegate = self
        return itemViewModel
    }

}

extension BaseStoryPreviewViewModel: StoryCellViewModelDelegate {

    func storyCellViewModelDidRequestClose(_ viewModel: StoryCellViewModel) {
        router.route(to: .dismiss)
    }

    func storyCellViewModel(_ viewModel: StoryCellViewModel, didChangeStoryWith direction: StoryPreviewDirection) {
        switch direction {
        case .next:
            guard currentStoryIndex.value != viewModels.count - 1 else { return router.route(to: .dismiss) }
            currentStoryIndex.value += 1
        case .previous:
            guard currentStoryIndex.value != 0 else { return action.value = .reload }
            currentStoryIndex.value -= 1
        }
    }

}
