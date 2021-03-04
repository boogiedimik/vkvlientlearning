//
//  RealmService.swift
//  VKClientLearning
//
//  Created by Dmitry Cherenkov on 17.12.2020.
//  Copyright © 2020 Dmitry Cherenkov. All rights reserved.
//

import Foundation
import RealmSwift

class RealmService {
    
    func saveToRealm<T: Object>(saveData: [T]) {
        do {
            let realm = try Realm()
            realm.beginWrite()
            realm.add(saveData, update: .modified)
            try realm.commitWrite()
        } catch {
            print(error)
        }
    }

    func loadFromRealm<T: Object>(type: T.Type) -> [T] {
        guard let realm = try? Realm() else { fatalError() }
        let results = Array(realm.objects(T.self))
        return results
    }
    
}


