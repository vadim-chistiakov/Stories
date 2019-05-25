//
//  StoryPage.swift
//  Stories
//
//  Created by Чистяков Вадим Евгеньевич on 25/05/2019.
//  Copyright © 2019 ChistProduction. All rights reserved.
//


import Foundation.NSURL

final class StoryPage: Equatable {

    let imageURL: URL
    let title: String
    let description: String

    init(imageURL: URL, title: String, description: String) {
        self.imageURL = imageURL
        self.title = title
        self.description = description
    }

    static func == (lhs: StoryPage, rhs: StoryPage) -> Bool {
        if  lhs.imageURL == rhs.imageURL,
            lhs.title == rhs.title,
            lhs.description == rhs.description {
            return true
        }
        return false
    }
}
