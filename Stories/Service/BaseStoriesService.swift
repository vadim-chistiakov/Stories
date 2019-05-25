//
//  BaseStoriesService.swift
//  Stories
//
//  Created by Чистяков Вадим Евгеньевич on 25/05/2019.
//  Copyright © 2019 ChistProduction. All rights reserved.
//


import Foundation.NSURL
import Alamofire

final class BaseStoriesService: StoriesService {

    private static let queue = DispatchQueue(label: "ru.stories.network_client_queue", attributes: .concurrent)

    private let mapper: StoriesMapper

    init(mapper: StoriesMapper) {
        self.mapper = mapper
    }

    func requestStories(with completion: @escaping StoriesCompletion) {
        request("https://test.ru", method: .get, parameters: nil, encoding: URLEncoding.default, headers: nil).responseJSON(queue: BaseStoriesService.queue) { [weak self] dateResponse in
            guard let self = self else { return }
            do {
                let response = try result.unwrap()
                let stories = try self.mapper.mapStories(from: response)
                completion(.success(stories))
            } catch {
                completion(.failure(error))
            }
        }
    }

}
