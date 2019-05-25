//
//  Story.swift
//  Stories
//
//  Created by Чистяков Вадим Евгеньевич on 25/05/2019.
//  Copyright © 2019 ChistProduction. All rights reserved.
//


import Foundation.NSURL

final class Story {

    let iconTitle: String
    let iconURL: URL
    let pages: [StoryPage]

    init(iconTitle: String, iconURL: URL, pages: [StoryPage]) {
        self.iconTitle = iconTitle
        self.iconURL = iconURL
        self.pages = pages
    }

}
