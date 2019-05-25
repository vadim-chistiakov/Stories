//
//  StoryCellViewModel.swift
//  Stories
//
//  Created by Чистяков Вадим Евгеньевич on 25/05/2019.
//  Copyright © 2019 ChistProduction. All rights reserved.
//


import Foundation.NSURL

final class BaseStoryCellViewModel: StoryCellViewModel {

    let currentPage: Observable<StoryPage?>
    let progressBarViewModel: StoryProgressBarViewModel

    weak var delegate: StoryCellViewModelDelegate?
    var currentPageIndex: Int? {
        guard let page = currentPage.value else { return nil }
        return pages.index(of: page)
    }

    private let pages: [StoryPage]

    init(pages: [StoryPage]) {
        self.pages = pages
        self.currentPage = Observable(pages.first)
        self.progressBarViewModel = BaseStoryProgressBarViewModel(pagesCount: pages.count)
        progressBarViewModel.delegate = self
    }

    func close() {
        delegate?.storyCellViewModelDidRequestClose(self)
    }

    func changeStoryPage(to direction: StoryPreviewDirection) {
        guard let page = currentPage.value else { return }
        switch direction {
        case .next:
            if let newPage = pages.next(after: page) {
                currentPage.value = newPage
            } else {
                changeStory(to: .next)
            }
        case .previous:
            if let newPage = pages.previous(before: page) {
                currentPage.value = newPage
            } else {
                changeStory(to: .previous)
            }
        }
    }

    func changeStory(to direction: StoryPreviewDirection) {
        delegate?.storyCellViewModel(self, didChangeStoryWith: direction)
    }

}

extension BaseStoryCellViewModel: NSCopying {
    func copy(with zone: NSZone? = nil) -> Any {
        return BaseStoryCellViewModel(pages: pages)
    }
}

extension BaseStoryCellViewModel: StoryProgressBarAnimator {

    func start() {
        guard let index = currentPageIndex else { return }
        progressBarViewModel.start(forIndex: index)
    }

    func pause() {
        guard let index = currentPageIndex else { return }
        progressBarViewModel.pause(forIndex: index)
    }

    func resume() {
        guard let index = currentPageIndex else { return }
        progressBarViewModel.resume(forIndex: index)
    }

    func stop() {
        guard let index = currentPageIndex else { return }
        progressBarViewModel.stop(forIndex: index)
    }

    func reset() {
        guard let index = currentPageIndex else { return }
        progressBarViewModel.reset(forIndex: index)
        changeStoryPage(to: .previous)
    }

}

extension BaseStoryCellViewModel: StoryProgressBarViewModelDelegate {
    func storyProgressBarViewModelDidFinishAnimation(_ viewModel: StoryProgressBarViewModel) {
        changeStoryPage(to: .next)
    }
}

private extension Collection where Element: Equatable {

    func next(after element: Element) -> Element? {
        guard let index = firstIndex(of: element) else { return nil }
        let nextIndex = self.index(after: index)
        guard nextIndex < endIndex else { return nil }
        return self[nextIndex]
    }

}

private extension BidirectionalCollection where Element: Equatable {

    func previous(before element: Element) -> Element? {
        guard let index = firstIndex(of: element), index > startIndex else { return nil }
        return self[self.index(before: index)]
    }
}
