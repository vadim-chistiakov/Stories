//
//  StoriesService.swift
//  Stories
//
//  Created by Чистяков Вадим Евгеньевич on 25/05/2019.
//  Copyright © 2019 ChistProduction. All rights reserved.
//


protocol StoriesService: class {
    typealias StoriesCompletion = (Result<[Story]>) -> Void
    func requestStories(with completion: @escaping StoriesCompletion)
}
