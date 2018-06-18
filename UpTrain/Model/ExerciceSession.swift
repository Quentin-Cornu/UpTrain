//
//  ExerciceSession.swift
//  UpTrain
//
//  Created by Quentin Cornu on 16/06/2018.
//  Copyright © 2018 Quentin. All rights reserved.
//

import Foundation
import RealmSwift

class ExerciceSession: Object {
    
    @objc dynamic var idSession: Int = -1
    @objc dynamic var idExercice: Int = -1
    @objc dynamic var reps: Int = 0

}
