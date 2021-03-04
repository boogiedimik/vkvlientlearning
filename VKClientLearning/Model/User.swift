//
//  User.swift
//  VKClientLearning
//
//  Created by Dmitry Cherenkov on 30.11.2020.
//  Copyright © 2020 Dmitry Cherenkov. All rights reserved.
//

import Foundation
import RealmSwift

final class User: Object, Decodable {
    
    @objc dynamic var id: Int = 0
    @objc dynamic var firstName: String = ""
    @objc dynamic var lastName: String = ""
    var fullName: String {
        get {
            return "\(self.firstName) \(self.lastName)"
        }
    }
    @objc dynamic var city: String? = nil
    @objc dynamic var photo: String? = ""
    @objc dynamic var isOnline: Bool = false
    
    enum UserKeys: String, CodingKey {
        case id
        case firstName = "first_name"
        case lastName = "last_name"
        case cityContainer = "city"
        case city = "title"
        case photo = "photo_50"
        case isOnline = "online"
    }
    
    convenience init(from decoder: Decoder) throws {
        self.init()
        
        let container = try decoder.container(keyedBy: UserKeys.self)
        
        self.id = try container.decode(Int.self, forKey: .id)
        self.firstName = try container.decode(String.self, forKey: .firstName)
        self.lastName = try container.decode(String.self, forKey: .lastName)
        self.photo = try? container.decode(String.self, forKey: .photo)
        let isOnline = try container.decode(Int.self, forKey: .isOnline)
        self.isOnline = isOnline == 0 ? false : true
        let cityContainer = try? container.nestedContainer(keyedBy: UserKeys.self, forKey: .cityContainer)
        self.city = try? cityContainer?.decode(String.self, forKey: .city)
        
    }
    
    override static func primaryKey() -> String {
        return "id"
    }
    
    override static func ignoredProperties() -> [String] {
        return ["isOnline"]
    }

}
