//
//  Extension+CKRecord.swift
//  Teachify
//
//  Created by Marcel Hagmann on 16.04.18.
//  Copyright © 2018 Christian Pfeiffer. All rights reserved.
//

import Foundation
import CloudKit

extension CKRecord {
    
    convenience init(tkClass: TKClass, withRecordZoneID recordZoneID: CKRecordZoneID) {
        self.init(recordType: TKCloudKey.RecordType.classes, zoneID: recordZoneID)
        self[TKClass.CloudKey.name] = tkClass.name as CKRecordValue
    }
    
    convenience init(student: TKStudent, withRecordZoneID recordZoneID: CKRecordZoneID) {
        self.init(recordType: TKCloudKey.RecordType.students, zoneID: recordZoneID)
        self[TKStudent.CloudKey.firstname] = student.firstname as CKRecordValue
        self[TKStudent.CloudKey.lastname] = student.lastname as CKRecordValue
        self[TKStudent.CloudKey.email] = student.email as CKRecordValue
    }
    
    convenience init(subject: TKSubject, withRecordZoneID recordZoneID: CKRecordZoneID) {
        self.init(recordType: TKCloudKey.RecordType.subjectes, zoneID: recordZoneID)
        self[TKSubject.CloudKey.name] = subject.name as CKRecordValue
        self[TKSubject.CloudKey.color] = subject.color.tkCloudKey as CKRecordValue
    }
    
    convenience init(document: TKDocument, withRecordZoneID recordZoneID: CKRecordZoneID) {
        self.init(recordType: TKCloudKey.RecordType.documents, zoneID: recordZoneID)
        self[TKDocument.CloudKey.name] = document.name as CKRecordValue
        
        guard let deadline = document.deadline else {
            return
        }
        self[TKDocument.CloudKey.deadline] = deadline as CKRecordValue
    }
    
    convenience init(exercise: TKExercise, withRecordZoneID recordZoneID: CKRecordZoneID) {
        self.init(recordType: TKCloudKey.RecordType.exercises, zoneID: recordZoneID)
        self[TKExercise.CloudKey.name] = exercise.name as CKRecordValue
        self[TKExercise.CloudKey.data] = exercise.data as CKRecordValue
        self[TKExercise.CloudKey.type] = exercise.type.tkCloudKey as CKRecordValue
        
        guard let deadline = exercise.deadline else {
            return
        }
        
        self[TKExercise.CloudKey.deadline] = deadline as CKRecordValue
    }
    
    convenience init(solution: TKSolution, withRecordZoneID recordZoneID: CKRecordZoneID) {
        self.init(recordType: TKCloudKey.RecordType.solution, zoneID: recordZoneID)
        self[TKSolution.CloudKey.userSolution] = solution.userSolution as CKRecordValue
        self[TKSolution.CloudKey.status] = solution.status.tkCloudKey as CKRecordValue
        self[TKSolution.CloudKey.ownerID] = solution.ownerID as CKRecordValue
    }
    
    convenience init?(cloudObject: TKCloudObject, withRecordZoneID recordZoneID: CKRecordZoneID) {
        if let tkClass = cloudObject as? TKClass {
            self.init(tkClass: tkClass, withRecordZoneID: recordZoneID)
        } else if let subject = cloudObject as? TKSubject {
            self.init(subject: subject, withRecordZoneID: recordZoneID)
        } else if let document = cloudObject as? TKDocument {
            self.init(document: document, withRecordZoneID: recordZoneID)
        } else if let exercise = cloudObject as? TKExercise {
            self.init(exercise: exercise, withRecordZoneID: recordZoneID)
        } else if let student = cloudObject as? TKStudent {
            self.init(student: student, withRecordZoneID: recordZoneID)
        } else if let solution = cloudObject as? TKSolution {
            self.init(solution: solution, withRecordZoneID: recordZoneID)
        } else {
            return nil
        }
    }
}
