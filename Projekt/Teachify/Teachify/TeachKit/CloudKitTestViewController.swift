//
//  CloudKitTestViewController.swift
//  Teachify
//
//  Created by Marcel Hagmann on 13.04.18.
//  Copyright © 2018 Christian Pfeiffer. All rights reserved.
//

import UIKit
import CloudKit

class CloudKitTestViewController: UIViewController {
    
    var classCtrl: TKClassController!
    var teacherCtrl: TKTeacherController!
    var subjectCtrl: TKSubjectController!
    var documentCtrl: TKDocumentController!
    var exerciseCtrl: TKExerciseController!
    var sharingCtrl: TKShareController!
    var settingsCtrl = TKSettingsController()

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction func setUpForStudent(_ sender: UIButton) {
        let rank = TKRank.student
        initCtrl(withRank: rank)
    }
    @IBAction func setUpForTeacher(_ sender: UIButton) {
        let rank = TKRank.teacher
        initCtrl(withRank: rank)
    }
    
    func initCtrl(withRank rank: TKRank) {
        classCtrl = TKClassController()
        classCtrl.initialize(withRank: rank) { (succeed) in
            print("Class init --> \(succeed)")
        }
        
        teacherCtrl = TKTeacherController()
        teacherCtrl.initialize(withRank: rank) { (succeed) in
            print("Teacher init --> \(succeed)")
        }
        
        subjectCtrl = TKSubjectController()
        subjectCtrl.initialize(withRank: rank) { (succeed) in
            print("Subject init --> \(succeed)")
        }
        
        documentCtrl = TKDocumentController()
        documentCtrl.initialize(withRank: rank) { (succeed) in
            print("Document init --> \(succeed)")
        }
        
        exerciseCtrl = TKExerciseController()
        exerciseCtrl.initialize(withRank: rank) { (succeed) in
            print("Exercise init --> \(succeed)")
        }
        
        sharingCtrl = TKShareController(view: self.view)
    }
    
    @IBAction func teacherAction(_ sender: UIButton) {
        self.classCtrl.fetchClasses { (fetchedClasses, error) in
            print("error: \(error) -- \(fetchedClasses.count)")
        }
    }
    
    @IBAction func studentAction(_ sender: UIButton) {
        self.subjectCtrl.fetchSubject { (fetchedSubjects, error) in
            print("subject error: \(error) -- count: \(fetchedSubjects.count)")
            for subject in fetchedSubjects {
                print("sss \(subject.name)")
                
                if subject.name == "Test Subject Name" {
                    print("in 1")
                    
                    self.sharingCtrl.createCloudSharingController(forSubject: subject, withShareOption: .addParticipant, completion: { (viewCtrl, error) in
                        print("error: \(error)")
                        if let viewCtrl = viewCtrl {
                            self.present(viewCtrl, animated: true)
                        }
                    })
                    
                }
                
            }
        }
    }
    
    @IBAction func doSomethingAction(_ sender: UIButton) {
        let aClass = TKClass(name: "12MH")
        let subject = TKSubject(name: "A Subject Name", color: TKColor.yellow)
        let document = TKDocument(name: "My Document 4 uploaded before sharing", deadline: nil)
        
        self.subjectCtrl.fetchSubject { (fetchedSubjects, error) in
            print("subject error: \(error) -- count: \(fetchedSubjects.count)")
            for subject in fetchedSubjects {
                print("sss \(subject.name)")
                
//                if subject.name == "A Subject Name" {
//                    print("in 1")
//                    if let record = subject.record {
//                        print("in 2")
//                        let share = CKShare(rootRecord: record)
//                        let doc = CKRecord(document: document, withRecordZoneID: CKRecordZone.teachKitZone.zoneID)
//
//                        print("in 3 - \(share.recordID.recordName)")
//
//                        let configuration = CKOperationConfiguration()
//                        configuration.timeoutIntervalForRequest = 10
//                        configuration.timeoutIntervalForResource = 10
//
//                        let test = CKModifyRecordsOperation(recordsToSave: [share, doc], recordIDsToDelete: nil)
//                        test.configuration = configuration
//
//                        test.modifyRecordsCompletionBlock = { hello, world, error in
//                            print("eeeeror: \(error) -- \(hello?.count)")
//                        }
//                        CKContainer.default().privateCloudDatabase.add(test)
//                    }
//                }
                
            }
        }
    }
    
    func create(className: String, subjectName: String, documentName: String, exerciseName: String) {
        let tkClass = TKClass(name: className)
        let tkSubject = TKSubject(name: subjectName, color: TKColor.red)
        let tkDocument = TKDocument(name: documentName, deadline: nil)
        let tkExercise = TKExercise(name: exerciseName, deadline: nil, type: .wordTranslation, data: "Daaaata")
        
        self.classCtrl.create(tkClass: tkClass) { (createdClass, error) in
            print("Class Error: \(error)")
            guard let createdClass = createdClass else { return }
            
            self.subjectCtrl.add(subject: tkSubject, toTKClass: createdClass, completion: { (createdSubject, error) in
                print("Subject Error: \(error)")
                guard let createdSubject = createdSubject else { return }
                
                self.documentCtrl.add(document: tkDocument, toSubject: createdSubject, completion: { (createdDocument, error) in
                    print("Document Error: \(error)")
                    guard let createdDocument = createdDocument else { return }
                    
                    self.exerciseCtrl.create(exercise: tkExercise, toDocument: createdDocument, completion: { (createdExercise, error) in
                        print("Exercise Error: \(error)")
                    })
                    
                })
                
            })
            
        }
    }
    
    func createExercise() {
        let exercise = TKExercise(name: "Aufgabe 120", deadline: nil, type: .wordTranslation, data: "Hello das ist die Dataaaaaa!")
        
        classCtrl.fetchClasses { (fetchedClasses, error) in
            
            for fetchedClass in fetchedClasses {
                if fetchedClass.name == "9a" {
                    
                    self.subjectCtrl.fetchSubject(forClass: fetchedClass, withFetchSortOptions: [], completion: { (fetchedSubjects, error) in
                        for subject in fetchedSubjects {
                            
                            if subject.name == "Deutsch" {
                                
                                self.documentCtrl.fetchDocuments(forSubject: subject, completion: { (fetchedDocuments, error) in
                                    for document in fetchedDocuments {
                                        if document.name == "If-Sätze" {
                                            
                                            self.exerciseCtrl.create(exercise: exercise, toDocument: document, completion: { (createdExercise, error) in
                                                print("error: \(error) -- \(createdExercise?.name)")
                                            })
                                            
                                        }
                                    }
                                })
                                
                            }
                        }
                    })
                    
                }
            }
            
        }
    }
    
    func shareASubject() {
        
    }
    
}
