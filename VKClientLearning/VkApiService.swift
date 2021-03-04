//
//  VkApiService.swift
//  VKClientLearning
//
//  Created by Dmitry Cherenkov on 26.11.2020.
//  Copyright © 2020 Dmitry Cherenkov. All rights reserved.
//


import Foundation
import UIKit


public enum GetUserMethod: String {
    case getFriends = "/method/friends.get"
    case getPhotos = "/method/photos.getAll"
    case getGroups = "/method/groups.get"
    case getSearchGroup = "/method/groups.search"
    case getPostFeed = "/method/newsfeed.get"
}

enum GetFriendsFields: String {
    case sex = "sex"
    case bdate = "bdate"
    case city = "city"
    case country = "country"
    case photo = "photo_50"
    case online = "online"
    case relation = "relation"
    case lastSeen = "last_seen"
    case status = "status"
}

class Items<T>: Decodable where T: Decodable {
    var items: [T]
}

class Response<T>: Decodable where T: Decodable {
    var response: Items<T>
}

final class VkApiService {
    
    let acessToken = Session.shared.accessToken
    let v = Session.shared.v
    
    private func getRequestUrl(method: GetUserMethod, userOrGroupId id: Int? = nil, groupSearchText text: String? = nil) -> URLRequest? {
        
        var request: URLRequest
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = "api.vk.com"
        
        switch method {
        
        case .getFriends:
            let fields = "\(GetFriendsFields.photo.rawValue),\(GetFriendsFields.city.rawValue),\(GetFriendsFields.online.rawValue)"
            urlComponents.path = method.rawValue
            urlComponents.queryItems = [
                URLQueryItem(name: "fields", value: fields)
            ]
        case .getPhotos:
            guard let id = id else { return nil }
            urlComponents.path = method.rawValue
            urlComponents.queryItems = [
                URLQueryItem(name: "owner_id", value: String(id)),
                URLQueryItem(name: "extended", value: "1"),
                URLQueryItem(name: "count", value: "200"),
                URLQueryItem(name: "no_service_albums", value: "0")
            ]
        case .getGroups:
            urlComponents.path = method.rawValue
            urlComponents.queryItems = [
                URLQueryItem(name: "extended", value: "1"),
            ]
        case .getSearchGroup:
            urlComponents.path = method.rawValue
            urlComponents.queryItems = [
                URLQueryItem(name: "q", value: text),
                URLQueryItem(name: "count", value: "100")
            ]
            
        case .getPostFeed:
            urlComponents.path = method.rawValue
            urlComponents.queryItems = [
                URLQueryItem(name: "filters", value: "post"),
                URLQueryItem(name: "count", value: "3")
            ]
        }
        
        urlComponents.queryItems? += [
            URLQueryItem(name: "access_token", value: acessToken),
            URLQueryItem(name: "v", value: v)
        ]
        
        guard let url = urlComponents.url else { return nil }
        request = URLRequest(url: url)
        return request
    }
    
    func getData<Type: Decodable>(method: GetUserMethod, responseType: Type.Type, userOrGroupId id: Int? = nil, groupSearchText text: String? = nil, completion: @escaping ([Type]) -> Void) {
        
        guard let request = getRequestUrl(method: method, userOrGroupId: id, groupSearchText: text) else { return }

        let session = URLSession.shared
        let task = session.dataTask(with: request) { (data, response, error) in
            
            guard let data = data else {
                completion([])
                return
            }
            
            do {
                let responseBlock = try JSONDecoder().decode(Response<Type>.self, from: data)
                DispatchQueue.main.async {
                    completion(responseBlock.response.items)
                }

            } catch {
                DispatchQueue.main.async {
                    print(error)
                    completion([])
                }
            }
            
        }
        task.resume()
    }
    

    
    // MARK: - Helpers
    

    
    func loadImage(stringUrl: String, completion: @escaping (UIImage?) -> Void) {
        let url = URL(string: stringUrl)!
        
        guard let data = try? Data(contentsOf: url) else {
            completion(nil)
            return
        }
        let image = UIImage(data: data)
        
        DispatchQueue.main.async {
            completion(image)
        }
    }
    
    public func generateNewsFeed(numberOfNews n: Int) -> [NewsFeedSample] {
        
        var generatedNews: [NewsFeedSample] = []
        
        for _ in 0..<n {
            
            let news = NewsFeedSample()
            news.fullAuthorName = Lorem.fullName
            news.date = String("\(Int.random(in: 0...30)).\(Int.random(in: 0...12)).2021 00:00")
            news.type = Bool.random() ? .post : .photo
            let i = Int.random(in: 0...4)
            if i != 0 {
                for _ in 0...Int.random(in: 0...i) {
                    news.photos.append(UIImage(systemName: "person.fill")!)
                }
            }
            news.text = Lorem.tweet
            news.isLiked = Bool.random()
            news.likesCount = Int.random(in: 0...100)
            news.commentsCount = Int.random(in: 0...50)
            news.repostCount = Int.random(in: 0...10)
            
            generatedNews.append(news)
        }
        
        return generatedNews
    }
    
}
