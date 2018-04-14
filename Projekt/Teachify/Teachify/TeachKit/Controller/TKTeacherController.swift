//
//  TKTeacherController.swift
//  Firebase Playground
//
//  Created by Marcel Hagmann on 06.04.18.
//  Copyright © 2018 Marcel Hagmann. All rights reserved.
//

import Foundation
import CloudKit

struct TKTeacherController: TeachKitCloudController {
    private var privateDatabase = CKContainer.default().privateCloudDatabase
    
    // MARK: - Student Group Operations
    func fetchStudents(withFetchSortOptions fetchSortOptions: [TKFetchSortOption] = [],
                         completion: @escaping ([TKStudent], TKError?) -> ()) {
        
        fetchTeachKitRecordZone { (teachKitRecordZone, error) in
            guard let teachKitRecordZone = teachKitRecordZone else {
                completion([], TKError.dooooImplement)
                return
            }
            
            let predicate = NSPredicate(format: "TRUEPREDICATE")
            let query = CKQuery(recordType: TKCloudKey.RecordType.students, predicate: predicate)
            self.privateDatabase.perform(query, inZoneWith: teachKitRecordZone.zoneID, completionHandler: { (fetchedStudentRecords, error) in
                let students = fetchedStudentRecords?.compactMap { TKStudent(record: $0) } ?? []
                if error == nil {
                    completion(students, nil)
                } else {
                    completion([], nil)
                }
            })
        }
        
    }
    
    func fetchStudents(inGroup groupName: String,
                       withFetchSortOptions fetchSortOptions: [TKFetchSortOption] = [],
                       completion: @escaping ([TKStudent], TKError?) -> ()) {
        
    }
    
    func update(oldClassGroupName: String, withNewClassGroupName newClassGroupName: String, completion: @escaping ([String], TKError?) -> ()) {
    }
    
    func delete(classGroupName: String, completion: @escaping (TKError?) -> ()) {
    }
    
    func add(student: TKStudent, toTKClass tkClass: TKClass, completion: @escaping (TKStudent?, TKError?) -> ()) {
        guard let classRecord = tkClass.record else {
            completion(nil, TKError.dooooImplement)
            return
        }
        
        let zone = CKRecordZone.teachKitZone
        let studentRecord = CKRecord(student: student, withRecordZoneID: zone.zoneID)
        let recordTypeID = classRecord.recordID.recordName.replacingOccurrences(of: "-", with: "pmp")
        studentRecord["\(recordTypeID)"] = CKReference(record: classRecord, action: CKReferenceAction.none)
        
        privateDatabase.save(studentRecord) { (uploadedRecord, error) in
            if error == nil {
                var student = student
                student.record = uploadedRecord
                completion(student, nil)
            } else {
                completion(nil, TKError.dooooImplement)
            }
        }
    }
    
    func remove(students: [TKStudent], fromGroupName groupName: String, completion: @escaping (TKError?) -> ()) {
    }
}

