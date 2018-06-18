//
//  Workout.swift
//  UpTrain
//
//  Created by Quentin Cornu on 02/06/2018.
//  Copyright © 2018 Quentin. All rights reserved.
//

import UIKit
import RealmSwift

class Workout: Object {
    
    @objc dynamic var id = -1
    @objc dynamic var imageName: String = "no name"
    @objc dynamic var name: String = "no name"
    @objc dynamic var rounds: Bool = false
    @objc dynamic var weight: Bool = false
    
    override static func primaryKey() -> String? {
        return "id"
    }
    
    static func IncrementaID() -> Int{
        let realm = try! Realm()
        if let retNext = realm.objects(Workout.self).sorted(byKeyPath: "id").last?.id {
            return retNext + 1
        } else {
            return 1
        }
    }
    
}

