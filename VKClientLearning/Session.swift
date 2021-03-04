//
//  Session.swift
//  VKClientLearning
//
//  Created by Dmitry Cherenkov on 23.11.2020.
//  Copyright © 2020 Dmitry Cherenkov. All rights reserved.
//

import Foundation

class Session {
    
    static let shared = Session()
    
    
    let appID: Int = 7676006
    let appToken: String = "7546d5d87546d5d87546d5d8107533f5be775467546d5d82afb87ce94373bd282f42b5f"
    var accessToken: String = ""
    var userId: Int = 0 //"122191529"
    var v: String = "5.126"
    
    //ВРЕМЕННО: параметр текущего юзера, например, для получения его фотографий
    
    var currentFriendId: String = "122191529"
    
    
    private init(){}
    
}
