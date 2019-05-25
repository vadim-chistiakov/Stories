//
//  StoryIconCellViewModel.swift
//  Stories
//
//  Created by Чистяков Вадим Евгеньевич on 25/05/2019.
//  Copyright © 2019 ChistProduction. All rights reserved.
//


import Foundation.NSURL

final class StoryIconCellViewModel {

    let title: String
    let imageURL: URL

    init(title: String, imageURL: URL) {
        self.title = title
        self.imageURL = imageURL
    }

}
