//
//  Group.swift
//  VKClientLearning
//
//  Created by Dmitry Cherenkov on 14.12.2020.
//  Copyright © 2020 Dmitry Cherenkov. All rights reserved.
//

import Foundation
import RealmSwift

final class Group: Object, Decodable {
    
    @objc dynamic var id: Int = 0
    @objc dynamic var name: String = ""
    @objc dynamic var isMember: Bool = false
    @objc dynamic var photo: String = ""
    
    enum GroupKeys: String, CodingKey {
        case id
        case name
        case isMember = "is_member"
        case photo = "photo_50"
    }
    
    convenience init(from decoder: Decoder) throws {
        self.init()
        
        let container = try decoder.container(keyedBy: GroupKeys.self)
        
        self.id = try container.decode(Int.self, forKey: .id)
        self.name = try container.decode(String.self, forKey: .name)
        let isMember = try container.decode(Int.self, forKey: .isMember)
        self.isMember = isMember == 0 ? false : true
        self.photo = try container.decode(String.self, forKey: .photo)
    }
    
    override static func primaryKey() -> String {
        return "id"
    }
    
}
