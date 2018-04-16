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
    // ✅
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
    
    // ✅
    func update(student: TKStudent, completion: @escaping (TKStudent?, TKError?) -> ()) {
        guard let record = student.record else {
            completion(nil, TKError.dooooImplement)
            return
        }
        
        privateDatabase.save(record) { (updatedRecord, error) in
            if let updatedRecord = updatedRecord {
                let student = TKStudent(record: updatedRecord)
                completion(student, nil)
            } else {
                completion(nil, TKError.dooooImplement)
            }
        }
    }
    
    // ✅
    func delete(student: TKStudent, completion: @escaping (TKError?) -> ()) {
        guard let record = student.record else {
            completion(TKError.dooooImplement)
            return
        }
        
        privateDatabase.delete(withRecordID: record.recordID) { (deletedRecordID, error) in
            if error == nil {
                completion(nil)
            } else {
                completion(TKError.dooooImplement)
            }
        }
    }
    
    // ✅ Wichtig: Mehrere Studenten können gleichzeit einer Klasse zugewiesen werden,
    //             aber ein Student, kann nicht gleichzeit mehreren Klassen zugewiesen werden
    //             --> "Server Record Changed"
    func add(student: TKStudent, toTKClass tkClass: TKClass, completion: @escaping (TKStudent?, TKError?) -> ()) {
        guard let classRecord = tkClass.record, let studentRecord = student.record else {
            completion(nil, TKError.dooooImplement)
            return
        }
        
        var recordTypeID = classRecord.recordID.recordName.replacingOccurrences(of: "-", with: "")
        recordTypeID.insert(contentsOf: "class", at: recordTypeID.startIndex)
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
    
    // ✅
    func create(student: TKStudent, completion: @escaping (TKStudent?, TKError?) -> ()) {
        let zone = CKRecordZone.teachKitZone
        let studentRecord = CKRecord(student: student, withRecordZoneID: zone.zoneID)
        
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
}








