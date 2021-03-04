//
//  UserPhotos.swift
//  VKClientLearning
//
//  Created by Dmitry Cherenkov on 06.12.2020.
//  Copyright © 2020 Dmitry Cherenkov. All rights reserved.
//

import Foundation
import RealmSwift

final class UserPhotos: Object, Decodable {

    @objc dynamic var id: Int = 0
    @objc dynamic var text: String = ""
    
    @objc dynamic var likedByUser: Int = 0
    @objc dynamic var likesCount: Int = 0
    
    @objc dynamic var previewPhoto: String = ""
    @objc dynamic var fullSizePhoto: String = ""
    
    @objc dynamic var date: Int = 0
    @objc dynamic var ownerId: Int = 0

    enum CodingKeys: String, CodingKey {
        case id
        case date
        case ownerId = "owner_id"
        case sizes
        case text
        case likes
    }
    
    enum SizesKeys: String, CodingKey {
        case url
        case type
    }
    
    enum UserLikesKeys: String, CodingKey {
        case likedByUser = "user_likes"
        case likesCount = "count"
    }

    convenience init(from decoder: Decoder) throws {
        self.init()
        
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(Int.self, forKey: .id)
        self.date = try container.decode(Int.self, forKey: .date)
        self.ownerId = try container.decode(Int.self, forKey: .ownerId)
        
        var sizesContainer = try container.nestedUnkeyedContainer(forKey: .sizes)
        var allUrls: [String] = []
        while !(sizesContainer.isAtEnd) {
            let allSizesContainer = try sizesContainer.nestedContainer(keyedBy: SizesKeys.self)
            let urls = try allSizesContainer.decode(String.self, forKey: .url)
            allUrls.append(urls)
        }
        
        self.previewPhoto = allUrls[0]
        self.fullSizePhoto = allUrls[allUrls.count - 1]
        
        let likesContainer = try container.nestedContainer(keyedBy: UserLikesKeys.self, forKey: .likes)
        self.likedByUser = try likesContainer.decode(Int.self, forKey: .likedByUser)
        self.likesCount = try likesContainer.decode(Int.self, forKey: .likesCount)
    }
    
    override static func primaryKey() -> String {
        return "id"
    }
    
}

