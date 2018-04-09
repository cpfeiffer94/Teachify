//
//  OfflineCloud.swift
//  Teachify
//
//  Created by Marcel Hagmann on 09.04.18.
//  Copyright © 2018 Christian Pfeiffer. All rights reserved.
//

import Foundation
import CloudKit
import UIKit

class OfflineCloud {
    private init() {
        createDummyContent()
    }
    
    public static var server = OfflineCloud()
    
    // Teacher Stuff
    public var dummyTeacher: TKUser!
    public var teacherGroups: [String] = []
    public var teacherGroupsDic: [String:[TKStudent]] = [:]
    //    public var teacherDirectories: [String:[String]] = [:] // TeacherID : [SubjectID]
    
    // Student Stuff
    public var dummyStudent: TKUser!
    
    // Leaderboard Stuff
    public var leaderboards: [TKExerciseType: [TKScore]] = [:]
    
    
    
    private func createDummyContent() {
        // Teacher Stuff
        let teacherRecord = CKRecord(recordType: "User")
        var teacher = TKUser(record: teacherRecord)
        teacher.email = "JohnnAppleseed@apple.com"
        teacher.firstname = "Johnn"
        teacher.lastname = "Appleseed"
        teacher.image = UIImage(named: "teacherImage")
        dummyTeacher = teacher
        
        
        // Student Stuff
        let studentRecord = CKRecord(recordType: "User")
        var student = TKUser(record: studentRecord)
        student.email = "JohnnAppleseed_student@apple.com"
        student.firstname = "Johnn"
        student.lastname = "Appleseed_student"
        student.image = UIImage(named: "studentImage")
        dummyStudent = student
        
        
        // Teacher Group Stuff
        teacherGroups =  ["7c", "4a", "11b"]
        for group in teacherGroups {
            teacherGroupsDic[group] = []
        }
        
        // Leaderboard Stuff
        for exerciseType in TKExerciseType.allExerciseTypes {
            var scores: [TKScore] = []
            for _ in 0..<50 {
                let scoreRecord = CKRecordID(recordName: "Leaderboard")
                let randomScore = Int(arc4random_uniform(100) + 50)
                let score = TKScore(scoredUserRecordID: scoreRecord, scoreValue: randomScore, exerciseType: .wordTranslation)
                scores.append(score)
            }
            leaderboards[exerciseType] = scores
            sortLeaderboard(forExerciseType: exerciseType)
        }
    }
    
    func sortLeaderboard(forExerciseType exerciseType: TKExerciseType) {
        guard var scores = leaderboards[exerciseType] else { return }
        scores.sort { (score1, score2) -> Bool in
            return score1.scoreValue > score2.scoreValue
        }
        leaderboards[exerciseType] = scores
    }
}










