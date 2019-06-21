//
//  BaseStoriesMapper.swift
//  Stories
//
//  Created by Чистяков Вадим Евгеньевич on 25/05/2019.
//  Copyright © 2019 ChistProduction. All rights reserved.
//


import JASON

private extension JSONKeys {
    static let stories = JSONKey<JSON>("stories")
    static let iconURL = JSONKey<String>("iconURL")
    static let iconTitle = JSONKey<String>("iconTitle")
    static let pageImageURL = JSONKey<String>("imageURL")
    static let pages = JSONKey<JSON>("pages")
    static let imageTitle = JSONKey<String>("title")
    static let imageDescription = JSONKey<String>("description")
}

enum NetworkError: Error {
    case mapper
}

final class BaseStoriesMapper: StoriesMapper {

    func mapStories(from response: Any?) throws -> [Story] {
        let jsonArray = JSON(response).jsonArrayValue
        return jsonArray.compactMap { try? mapStory(from: $0) }
    }

    private func mapStory(from json: JSON) throws -> Story {
        let iconURLString = json[.iconURL]
        let iconTitle = json[.iconTitle]
        let jsonPages = json[.pages].jsonArrayValue
        guard let iconURL = URL(string: iconURLString),
            let pages = try? jsonPages.compactMap(mapStoryPage)
            else { throw NetworkError.mapper }
        return Story(iconTitle: iconTitle, iconURL: iconURL, pages: pages)
    }

    private func mapStoryPage(from json: JSON) throws -> StoryPage {
        let title = json[.imageTitle]
        let description = json[.imageDescription]
        let imageURLString = json[.pageImageURL]
        guard let imageURL = URL(string: imageURLString) else { throw NetworkError.mapper }
        return StoryPage(imageURL: imageURL, title: title, description: description)
    }

}
