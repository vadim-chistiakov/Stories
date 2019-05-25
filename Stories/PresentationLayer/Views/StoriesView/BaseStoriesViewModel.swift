//
//  BaseStoriesViewModel.swift
//  Stories
//
//  Created by Чистяков Вадим Евгеньевич on 25/05/2019.
//  Copyright © 2019 ChistProduction. All rights reserved.
//


final class BaseStoriesViewModel: StoriesViewModel {

    var numberOfItems: Int {
        return models.count
    }

    let action: Dynamic<StoriesViewModelAction?> = Dynamic(nil)

    private let service: StoriesService
    private let router: StoriesRouter
    private var models: [Story] = []

    init(service: StoriesService, router: StoriesRouter) {
        self.service = service
        self.router = router
        requestViewModels()
    }

    func viewModelForItem(atIndex index: Int) -> StoryIconCellViewModel? {
        guard let story = models[safe: index] else { return nil }
        return StoryIconCellViewModel(title: story.iconTitle, imageURL: story.iconURL)
    }

    func selectStory(atIndex index: Int) {
        let storyPreviewViewModels = models.map { BaseStoryCellViewModel(pages: $0.pages) }
        router.route(to: .showStoryPreview(storyPreviewViewModels, index))
    }

    private func requestViewModels() {
        service.requestStories { [weak self] result in
            switch result {
            case .success(let stories):
                self?.models = stories
                self?.action.value = .reload
            case .failure:
                //TODO: handle failure
                return
            }
        }
    }
}
