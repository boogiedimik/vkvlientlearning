//
//  UserFriends.swift
//  VKClientLearning
//
//  Created by Dmitry Cherenkov on 19.10.2020.
//  Copyright © 2020 Dmitry Cherenkov. All rights reserved.
//

import Foundation
import UIKit

// MARK: User Friend Class

//class UserFriend {
//
//    var id: String
//    var firstName: String
//    var lastName: String
//    var fullName: String
//    var city: String
//    var avatar: UIImage?
//    var photos: [UserPhotos]?
//    var posts: [UserPosts]?
//
//
//    init(id: String, firstName: String, lastName: String, city: String, avatar: UIImage?, photos: [UserPhotos]?, posts: [UserPosts]?) {
//        self.id = id
//        self.firstName = firstName
//        self.lastName = lastName
//        self.fullName = "\(firstName) \(lastName)"
//        self.city = city
//        self.avatar = avatar
//        self.photos = photos
//        self.posts = posts
//    }
//
//}

//class UserPhotos {
//
//    var photo: UIImage
//    var photoIsLikedByUser: Bool
//    var likesCount: Int
//
//    init(photo: UIImage, photoIsLikedByUser: Bool, likesCount: Int) {
//
//        self.photo = photo
//        self.photoIsLikedByUser = photoIsLikedByUser
//        self.likesCount = likesCount
//    }
//
//}

//class UserPosts {
//    
//    var postedDateTime: Date
//    var postText: String
//    var images: [UIImage]?
//    var likesCount: Int
//    var isLikedByUser: Bool
//    
//    init(postedDateTime: Date, postText: String, images: [UIImage]?, likesCount: Int, isLikedByUser: Bool) {
//        
//        self.postedDateTime = postedDateTime
//        self.postText = postText
//        self.images = images
//        self.likesCount = likesCount
//        self.isLikedByUser = isLikedByUser
//        
//    }
//    
//}
//
//class Post {
//    
//    var fullName: String
//    var avatar: UIImage?
//    var postedDateTime: Date
//    var postText: String
//    var images: [UIImage]?
//    var likesCount: Int
//    var isLikedByUser: Bool
//    
//    init(fullName: String, avatar: UIImage?, postedDateTime: Date, postText: String, images: [UIImage]?, likesCount: Int, isLikedByUser: Bool) {
//        
//        self.fullName = fullName
//        self.avatar = avatar
//        self.postedDateTime = postedDateTime
//        self.postText = postText
//        self.images = images
//        self.likesCount = likesCount
//        self.isLikedByUser = isLikedByUser
//        
//    }
//    
//}
//
//class City {
//
//    public static var city: String {
//        return String(cities.randomElement()!)
//    }
//
//    fileprivate static let cities = """
//    Moscow
//    Saint Petersburg
//    Novosibirsk
//    Yekaterinburg
//    Kazan
//    Nizhny Novgorod
//    Chelyabinsk
//    Samara
//    Omsk
//    Rostov-on-Don
//    Ufa
//    Krasnoyarsk
//    Voronezh
//    Perm
//    Volgograd
//    Krasnodar
//    Saratov
//    Tyumen
//    Tolyatti
//    Izhevsk
//    Barnaul
//    Ulyanovsk
//    Irkutsk
//    Khabarovsk
//    Yaroslavl
//    Vladivostok
//    Makhachkala
//    Tomsk
//    Orenburg
//    Kemerovo
//    Novokuznetsk
//    Ryazan
//    Naberezhnye Chelny
//    Astrakhan
//    Penza
//    Kirov
//    Lipetsk
//    Balashikha
//    Cheboksary
//    Kaliningrad
//    Tula
//    Kursk
//    Stavropol
//    Sochi
//    Ulan-Ude
//    Tver
//    Magnitogorsk
//    Ivanovo
//    Sevastopol
//    Bryansk
//    Belgorod
//    Surgut
//    Vladimir
//    Chita
//    Nizhny Tagil
//    Arkhangelsk
//    Simferopol
//    Kaluga
//    Smolensk
//    Volzhsky
//    Yakutsk
//    Saransk
//    Cherepovets
//    Kurgan
//    Vologda
//    Oryol
//    Podolsk
//    Grozny
//    Vladikavkaz
//    Tambov
//    Murmansk
//    Petrozavodsk
//    Nizhnevartovsk
//    Kostroma
//    Sterlitamak
//    Novorossiysk
//    Yoshkar-Ola
//    Khimki
//    Taganrog
//    Komsomolsk-on-Amur
//    Syktyvkar
//    Nizhnekamsk
//    Nalchik
//    Mytishchi
//    Shakhty
//    Dzerzhinsk
//    Engels
//    Orsk
//    Blagoveshchensk
//    Bratsk
//    Korolyov
//    Veliky Novgorod
//    Angarsk
//    Stary Oskol
//    Pskov
//    Lyubertsy
//    Yuzhno-Sakhalinsk
//    Biysk
//    Prokopyevsk
//    Armavir
//    Balakovo
//    Abakan
//    """.split(separator: "\n").map { $0 }
//
//}
