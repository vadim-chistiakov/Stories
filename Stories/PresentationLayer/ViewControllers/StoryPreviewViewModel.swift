//
//  StoryPreviewViewModel.swift
//  Stories
//
//  Created by Чистяков Вадим Евгеньевич on 25/05/2019.
//  Copyright © 2019 ChistProduction. All rights reserved.
//


enum StoryPreviewViewModelAction {
    case reload
}

protocol StoryPreviewViewModel: class {
    var currentStoryIndex: Observable<Int> { get }
    var action: Observable<StoryPreviewViewModelAction?> { get }
    var numberOfItems: Int { get }

    func viewModelForItem(atIndex index: Int) -> StoryCellViewModel?
}
