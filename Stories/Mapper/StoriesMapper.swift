//
//  StoriesMapper.swift
//  Stories
//
//  Created by Чистяков Вадим Евгеньевич on 25/05/2019.
//  Copyright © 2019 ChistProduction. All rights reserved.
//


protocol StoriesMapper: class {
    func mapStories(from response: Any?) throws -> [Story]
}
