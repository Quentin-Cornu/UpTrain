//
//  DBManager.swift
//  UpTrain
//
//  Created by Quentin Cornu on 09/06/2018.
//  Copyright © 2018 Quentin. All rights reserved.
//

import Foundation
import RealmSwift

class DBManager {
    
    let realm = try! Realm()
    
    init() {
        print("Realm file path : \(String(describing: Realm.Configuration.defaultConfiguration.fileURL))")
    }
    
    func add(_ object: Object) {
        try! realm.write {
            realm.add(object)
        }
    }
    
    func fetchWorkouts() -> [Workout] {
        var workouts = [Workout]()
        let result = realm.objects(Workout.self)
        
        for object in result {
            workouts.append(object)
        }
        
        return workouts
    }
    
    func fetchExercices(idWorkout: Int) -> [Exercice] {
        var exercices = [Exercice]()
        let result = realm.objects(Exercice.self).filter("noWorkout = \(idWorkout)")
        
        for object in result {
            exercices.append(object)
        }
        
        return exercices
    }
    
    func fetchExercicesSession(idSession: Int) -> [ExerciceSession] {
        var exercices = [ExerciceSession]()
        let result = realm.objects(ExerciceSession.self).filter("idSession = \(idSession)")
        
        for object in result {
            exercices.append(object)
        }
        
        return exercices
    }
    
    func fetchSessions(idWorkout: Int) -> [Session] {
        var sessions = [Session]()
        let result = realm.objects(Session.self).filter("noWorkout = \(idWorkout)")
        
        for object in result {
            sessions.append(object)
        }
        
        return sessions
    }
    
    func fetchResults(for idWorkout: Int) -> [Int] {
        let sessions = fetchSessions(idWorkout: idWorkout)
        var results = [Int]()

        for session in sessions {
            let exSession = fetchExercicesSession(idSession: session.id)
            var totalReps = 0
            
            for exo in exSession {
                totalReps += exo.reps
            }
            
            results.append(totalReps)
        }
        
        return results
    }
    
}
