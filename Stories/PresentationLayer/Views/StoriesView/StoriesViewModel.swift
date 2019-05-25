//
//  StoriesViewModel.swift
//  Stories
//
//  Created by Чистяков Вадим Евгеньевич on 25/05/2019.
//  Copyright © 2019 ChistProduction. All rights reserved.
//


enum StoriesViewModelAction {
    case reload
}

protocol StoriesViewModel: class {
    var numberOfItems: Int { get }
    var action: Observable<StoriesViewModelAction?> { get }

    func viewModelForItem(atIndex index: Int) -> StoryIconCellViewModel?
    func selectStory(atIndex index: Int)
}
