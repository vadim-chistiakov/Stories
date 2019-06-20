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

    private let queue = DispatchQueue(label: "ru.stories.network_client_queue", attributes: .concurrent)
    private let mapper: StoriesMapper

    init(mapper: StoriesMapper) {
        self.mapper = mapper
    }

    func requestStories(with completion: @escaping StoriesCompletion) {
        request("https://test.ru", method: .get, parameters: nil, encoding: URLEncoding.default, headers: nil).responseJSON(queue: queue) { [weak self] dateResponse in
            guard let self = self else { return }
            DispatchQueue.main.async { [weak self] in
                let stories = self?.generateTestViewModels()
                completion(.success(stories!))
                return
            }
            // Временно генерируем тестовые данные вручную
//            do {
//                let response = try dateResponse.unwrap()
//                let stories = try self.mapper.mapStories(from: response)
//                completion(.success(stories))
//            } catch {
//                completion(.failure(error))
//            }
        }
    }

    private func generateTestViewModels() -> [Story] {
        return [Story(iconTitle: "TitleString",
                      iconURL: URL(string: "https://avatars.mds.yandex.net/get-pdb/1779125/877f261f-f3fe-442a-9551-322855b86b76/s1200")!, pages:
            [StoryPage(imageURL: URL(string: "https://avatars.mds.yandex.net/get-pdb/1779125/877f261f-f3fe-442a-9551-322855b86b76/s1200")!,
                       title: "Test Title",
                       description: "Test Description Test Description Test Description"),
             StoryPage(imageURL: URL(string: "https://avatars.mds.yandex.net/get-pdb/69339/3cc3bee7-92ad-4764-95b3-1564b40e5491/s1200")!,
                       title: "Test Title2",
                       description: "Test Description Test Description  Test Description2 Test Description2 Test Description2"),
             StoryPage(imageURL: URL(string: "https://avatars.mds.yandex.net/get-pdb/911433/88d9f108-cc8d-4717-a23f-311c83b2408c/s1200")!,
                       title: "Test Title23423423",
                       description: "Test Description Test Description  Test Description2 Test Description2 Test Description2sdfsdf n Test Description  Test Description2 Test Description2 Test Description2sdfsdf n Test Description  Test Description2 Test Description2 Test Description2sdfsdf")]),
                Story(iconTitle: "TitleString",
                      iconURL: URL(string: "https://avatars.mds.yandex.net/get-pdb/1779125/877f261f-f3fe-442a-9551-322855b86b76/s1200")!, pages:
                    [StoryPage(imageURL: URL(string: "https://avatars.mds.yandex.net/get-pdb/1779125/877f261f-f3fe-442a-9551-322855b86b76/s1200")!,
                               title: "Test Title",
                               description: "Test Description Test Description Test Description"),
                     StoryPage(imageURL: URL(string: "https://avatars.mds.yandex.net/get-pdb/69339/3cc3bee7-92ad-4764-95b3-1564b40e5491/s1200")!,
                               title: "Test Title2",
                               description: "Test Description Test Description  Test Description2 Test Description2 Test Description2"),
                     StoryPage(imageURL: URL(string: "https://avatars.mds.yandex.net/get-pdb/911433/88d9f108-cc8d-4717-a23f-311c83b2408c/s1200")!,
                               title: "Test Title23423423",
                               description: "Test Description Test Description  Test Description2 Test Description2 Test Description2sdfsdf n Test Description  Test Description2 Test Description2 Test Description2sdfsdf n Test Description  Test Description2 Test Description2 Test Description2sdfsdf")])]

    }


}
