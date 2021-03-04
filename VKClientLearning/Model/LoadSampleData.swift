//
//  LoadSampleData.swift
//  VKClientLearning
//
//  Created by Dmitry Cherenkov on 03.11.2020.
//  Copyright © 2020 Dmitry Cherenkov. All rights reserved.
//

import Foundation
import UIKit

// MARK: - Generate Functions

//private func generateUserFriend() -> UserFriend {
//    
//    let firstName = Lorem.firstName
//    let lastName = Lorem.lastName
//    let id = "\(firstName)_\(lastName)_\(String(Int.random(in: 0...999)))"
//    let city = City.city
//    let avatar = UIImage(named: String(Int.random(in: 1...70)))
//    let photos = generateUserPhotos()
//    let posts = generatePosts()
//
//    return UserFriend(id: id, firstName: firstName, lastName: lastName, city: city, avatar: avatar, photos: photos, posts: posts)
//
//}

//private func generateUserPhotos() -> [UserPhotos] {
//    var userPhotos: [UserPhotos] = []
//
//    for _ in 0..<Int.random(in: 1...100) {
//
//        let photo = UIImage(named: String(Int.random(in: 1...70)))
//        let photoIsLiked = Bool.random()
//        let likes = Int.random(in: 0...100)
//
//        userPhotos.append(UserPhotos(photo: photo!, photoIsLikedByUser: photoIsLiked, likesCount: likes))
//    }
//
//    return userPhotos
//}

//private func generatePosts() -> [UserPosts] {
//    var posts: [UserPosts] = []
//    
//    for _ in 0..<Int.random(in: 0...4) {
//        let postDate = Date(timeIntervalSinceNow: Double.random(in: (-84600 * 200)...0))
//        let postText = Lorem.tweet
//        var images: [UIImage] = []
//        for _ in 0..<Int.random(in: 0...5) {
//            images.append(UIImage(named: String(Int.random(in: 1...70)))!)
//        }
//        let likes = Int.random(in: 0...100)
//        let isLike = Bool.random()
//        
//        posts.append(UserPosts(postedDateTime: postDate, postText: postText, images: images, likesCount: likes, isLikedByUser: isLike))
//    }
//    
//    return posts
//}
//
//// MARK: - Load Sample Data User Friends
//
////func loadSampleUserFriendsData(_ namberOfUsers: Int) -> [UserFriend] {
////    
////    return (1...namberOfUsers).map { _ in generateUserFriend() }
////
////}
//    
//// MARK: - Load Sample User Gropus Data Function
//
//func loadSampleUserGroupsData() -> [UserGroup] {
//    
//    guard let firstChannel = UserGroup(id: 001,
//                                       name: "Первый канал",
//                                       avatar: UIImage(named: "firstChannel"),
//                                       userSubscribed: true)
//    else { fatalError("Unable to instantiate " + #function) }
//    
//    guard let ozero = UserGroup(id: 002,
//                                name: "Кооператив Озеро. Общение соседей",
//                                avatar: UIImage(named: "ozero"),
//                                userSubscribed: true)
//    else { fatalError("Unable to instantiate " + #function) }
//    
//    guard let bigEight = UserGroup(id: 003,
//                                   name: "Большая восьмерка. Закрыто(",
//                                   avatar: UIImage(named: "bigEight"),
//                                   userSubscribed: true)
//    else { fatalError("Unable to instantiate " + #function) }
//    
//    guard let opposition = UserGroup(id: 004,
//                                     name: "Оппозация. Сремся здесь",
//                                     avatar: UIImage(named: "opposition"),
//                                     userSubscribed: false)
//    else { fatalError("Unable to instantiate " + #function) }
//    
//    guard let oprichnik = UserGroup(id: 005,
//                                    name: "Опричник. Коллеги по ФСБ.",
//                                    avatar: UIImage(named: "oprichnik"),
//                                    userSubscribed: false)
//    else { fatalError("Unable to instantiate " + #function) }
//    
//    guard let rpc = UserGroup(id: 006,
//                              name: "РПЦ. Бог с нами, а не вами.",
//                              avatar: UIImage(named: "rpc"),
//                              userSubscribed: false)
//    else { fatalError("Unable to instantiate " + #function) }
//    
//    guard let minsk = UserGroup(id: 007,
//                                name: "Минские соглашения. Соблюдать или ££%$%£ дать?",
//                                avatar: UIImage(named: "minsk"),
//                                userSubscribed: false)
//    else { fatalError("Unable to instantiate " + #function) }
//    
//    guard let sliv = UserGroup(id: 008,
//                               name: "ПОДСЛУШАНО в Администрации Президента",
//                               avatar: UIImage(named: "sliv"),
//                               userSubscribed: false)
//    else { fatalError("Unable to instantiate " + #function) }
//    
//    return [sliv, firstChannel, ozero, bigEight, opposition, oprichnik, rpc, minsk]
//    
//}
