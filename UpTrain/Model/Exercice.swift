//
//  Exercice.swift
//  UpTrain
//
//  Created by Quentin Cornu on 11/06/2018.
//  Copyright © 2018 Quentin. All rights reserved.
//

import Foundation
import RealmSwift

class Exercice: Object {
    
    @objc dynamic var id: Int = -1
    @objc dynamic var noWorkout: Int = -1
    @objc dynamic var name: String = ""
    
    override static func primaryKey() -> String? {
        return "id"
    }
    
    static func IncrementaID() -> Int{
        let realm = try! Realm()
        if let retNext = realm.objects(Exercice.self).sorted(byKeyPath: "id").last?.id {
            return retNext + 1
        } else {
            return 1
        }
    }
    
}
