//
//  NewsFeedSampleData.swift
//  VKClientLearning
//
//  Created by Dmitry Cherenkov on 27.02.2021.
//  Copyright © 2021 Dmitry Cherenkov. All rights reserved.
//

import Foundation
import UIKit

enum NewsFeedSampleType {
    case post, photo
}

class NewsFeedSample {
    
    var fullAuthorName: String = ""
    var date: String = ""
    var type: NewsFeedSampleType = .post
    var authorAvatar = UIImage(systemName: "person.fill")
    var photos: [UIImage] = []
    var text: String = ""
    var isLiked: Bool = false
    var likesCount: Int = 0
    var commentsCount: Int = 0
    var repostCount: Int = 0
    
}



