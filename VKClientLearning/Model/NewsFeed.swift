//
//  NewsFeed.swift
//  VKClientLearning
//
//  Created by Dmitry Cherenkov on 27.02.2021.
//  Copyright © 2021 Dmitry Cherenkov. All rights reserved.
//

import Foundation

//в апи

//    func getNewsFeed<Type: NewsFeedable>(responseType: Type.Type, completion: @escaping ([Type]) -> Void) {
//
//        guard let request = getRequestUrl(method: .getPostFeed) else { return }
//
//        let session = URLSession.shared
//
//        let task = session.dataTask(with: request) { (data, response, error) in
//
//            guard let data = data else {
//                completion([])
//                return
//            }
//
//            do {
//                let responseBlock = try JSONDecoder().decode(NewsResponse<Type>.self, from: data)
//                let newsFeedItems = self.addProfileInfoToNewsFeed(type: responseType, items: responseBlock.response.items, profiles: responseBlock.response.profiles, groups: responseBlock.response.groups)
//                DispatchQueue.main.async {
//                    completion(newsFeedItems)
//                }
//
//            } catch {
//                DispatchQueue.main.async {
//                    print(error)
//                    completion([])
//                }
//            }
//
//        }
//        task.resume()
//
//    }

//    func addProfileInfoToNewsFeed<T: NewsFeedable>(type: T.Type, items: [T], profiles: [User], groups: [Group]) -> [T] {
//        var newsFeedItems: [T] = items
//        for i in 0...newsFeedItems.count - 1 {
//            var authorId = newsFeedItems[i].authorId
//            if authorId >= 0 {
//                if let user = profiles.first(where: { $0.id == authorId }) { newsFeedItems[i].authorName = user.fullName }
//            } else {
//                authorId.negate()
//                if let group = groups.first(where: { $0.id == authorId }) { newsFeedItems[i].authorName = group.name }
//            }
//        }
//        return newsFeedItems
//    }

// во вьюконтроллер
//apiService.getNewsFeed(responseType: PostFeed.self) { [weak self] (postFeed) in
//    self?.newsFeed += postFeed
//    self?.tableView.reloadData()
//    //print(self?.newsFeed)
//}

enum NewsFeedType {
    case post, photo
}

protocol NewsFeedable: Decodable {
    var authorName: String { get set }
    var authorId: Int { get set }
}

class NewsResponse<T>: Decodable where T: Decodable {
    var response: NewsItems<T>
}

class NewsItems<T>: Decodable where T: Decodable {
    var items: [T]
    var profiles: [User]
    var groups: [Group]
}

class NewsFeed: NewsFeedable {
    
    var authorName: String = ""
    var authorId: Int = 0
    var date: Int = 0
    var type: String = ""
 
}

final class PostFeed: NewsFeed {
    
    //var date: Int = 0
    //var type: String = ""
    var postId: Int = 0
//    var text: String = ""
//    var attachPhotos: [String] = []
//    var commentsCount: Int = 0
//    var repostsCount: Int = 0
//    var viewsCount: Int = 0
    
    enum CodingKeys: String, CodingKey {
        case authorId = "source_id"
        case date
        case type
        case postId = "post_id"
//        case text
//        case attachPhotos
//        case commentsCount
//        case repostsCount
//        case viewsCount
//        case attachments
    }
    
    convenience required init(from decoder: Decoder) throws {

        self.init()
        
        let container = try decoder.container(keyedBy: CodingKeys.self)
        super.authorId = try container.decode(Int.self, forKey: .authorId)
        super.date = try container.decode(Int.self, forKey: .date)
        super.type = try container.decode(String.self, forKey: .type)
        self.postId = try container.decode(Int.self, forKey: .postId)
        
    }
    
}

//class PhotosFeed: NewsFeed, Decodable {
//
//    var photos: [String] = []
//
//    enum CodingKeys: String, CodingKey {
//        case date
//        case type
//        case postId = "post_id"
//    }
//
//}
