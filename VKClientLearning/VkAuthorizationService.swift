//
//  VkAuthorizationService.swift
//  VKClientLearning
//
//  Created by Dmitry Cherenkov on 24.11.2020.
//  Copyright © 2020 Dmitry Cherenkov. All rights reserved.
//

import Foundation

class VkAuthorizationService {
    
    let authorizeRequest: URLRequest = {
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = "oauth.vk.com"
        urlComponents.path = "/authorize"
        urlComponents.queryItems = [
            URLQueryItem(name: "client_id", value: String(Session.shared.appID)),
            URLQueryItem(name: "display", value: "mobile"),
            URLQueryItem(name: "redirect_uri", value: "https://oauth.vk.com/blank.html"),
            URLQueryItem(name: "scope", value: "270342"),//"262150"),
            URLQueryItem(name: "response_type", value: "token"),
            URLQueryItem(name: "v", value: "5.68"),
            URLQueryItem(name: "revoke", value: "1")
        ]
        let request = URLRequest(url: urlComponents.url!)
        return request
    }()
    
}
