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
    @IBOutlet weak var sharingQRImageView: UIImageView!
    @IBOutlet weak var linkToShareTextField: UITextField!
    
    var classCtrl: TKClassController!
    var teacherCtrl: TKTeacherController!
    var subjectCtrl: TKSubjectController!
    var documentCtrl: TKDocumentController!
    var exerciseCtrl: TKExerciseController!
    var sharingCtrl: TKShareController!
    var settingsCtrl = TKSettingsController()
    var solutionsCtrl: TKSolutionController!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        linkToShareTextField.addTarget(self, action: #selector(linkInputDidChange), for: .editingChanged)
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
        
        solutionsCtrl = TKSolutionController()
        solutionsCtrl.initialize(withRank: rank) { (succeed) in
            print("Solution init --> \(succeed)")
        }
        
        
        sharingCtrl = TKShareController(view: self.view)
    }
    
    // MARK: - IBActions
    
    @IBAction func shareSubjectAction(_ sender: UIButton) {
        let subjectNameToShare = "SubjectName17_123"
//        shareASubject(subjectName: subjectNameToShare)
        
        self.subjectCtrl.fetchSubject { (allSubjects, error) in
            for subject in allSubjects {
                if subject.name == subjectNameToShare {
                    let test = TKShareController(view: self.view)
                    test.createCloudSharingController(forSubject: subject, withShareOption: .removeParticipant, completion: { (removeCtrl, error) in
                        if let removeCtrl = removeCtrl {
                            self.present(removeCtrl, animated: true)
                        }
                    })
                }
            }
        }
        
    }
    
    @IBAction func fetchAllDocuments(_ sender: UIButton) {
        self.documentCtrl.fetchDocuments { (fetchedDocuments, error) in
            print("Number of Shared Documents: \(fetchedDocuments.count)")
            for document in fetchedDocuments {
                print("Shared Document Name: \(document.name)")
            }
        }
    }
    
    @IBAction func fetchAllSubjects(_ sender: UIButton) {
//        self.subjectCtrl.fetchSubject { (fetchedSubjects, error) in
//            print("Number of Shared Subjects: \(fetchedSubjects.count)")
//            for subject in fetchedSubjects {
//                print("Shared Subject Name: \(subject.name)")
//            }
//        }
        create(className: "ClassName17_123", subjectName: "SubjectName17_123", documentName: "DocumentNr17_123", exerciseName: "ExerciseNr17_123")
    }
    
    @IBAction func fetchAllExercises(_ sender: UIButton) {
        self.exerciseCtrl.fetchExercises { (fetchedExercises, error) in
            print("Number of Shared Exercises: \(fetchedExercises.count)")
            for exercise in fetchedExercises {
                print("Shared Exercise Name: \(exercise.name)")
            }
        }
    }
    
    @IBAction func deleteAllSharedStudentRecords(_ sender: UIButton) {
//        self.subjectCtrl.fetchSubject { (fetchedSubjects, error) in
//            for subject in fetchedSubjects {
//                self.subjectCtrl.delete(subject: subject, completion: { (deletionError) in
//                    print("deleted-subject-name: \(subject.name) -- deltion-error: \(deletionError)")
//                    let share = CKShare(rootRecord: CKRecord(recordType: "asd"))
//                    share.removeParticipant(<#T##participant: CKShareParticipant##CKShareParticipant#>)
//                    share.participants
//                })
//            }
//        }
    }
    
    @objc func linkInputDidChange() {
        if let inputString = linkToShareTextField.text {
            let qrCode = createQRCode(string: inputString)
            sharingQRImageView.image = qrCode
            print(":)")
        }
    }
    
    
    // MARK: - Hilfsmethoden
    func createQRCode(string: String) -> UIImage? {
        let data = string.data(using: .ascii, allowLossyConversion: false)
        let filter = CIFilter(name: "CIQRCodeGenerator")
        filter?.setValue(data, forKey: "inputMessage")
        
        if let ciImage = filter?.outputImage {
            let highResolutionCIImageQR = ciImage.transformed(by: CGAffineTransform(scaleX: 20, y: 20))
            return UIImage(ciImage: highResolutionCIImageQR)
        }
        return nil
    }
    
    
    // MARK: - Hilfsmethoden zum schnelleren testen der CloudController
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
        let className = "17a"
        let subjectName = "Subject17"
        let documentName = "Document17"
        
        let exercise = TKExercise(name: "Aufgabe17", deadline: nil, type: .wordTranslation, data: "Hello das ist die Dataaaaaa!")
        
        classCtrl.fetchClasses { (fetchedClasses, error) in
            
            for fetchedClass in fetchedClasses {
                if fetchedClass.name == className {
                    
                    self.subjectCtrl.fetchSubject(forClass: fetchedClass, withFetchSortOptions: [], completion: { (fetchedSubjects, error) in
                        for subject in fetchedSubjects {
                            
                            if subject.name == subjectName {
                                
                                self.documentCtrl.fetchDocuments(forSubject: subject, completion: { (fetchedDocuments, error) in
                                    for document in fetchedDocuments {
                                        if document.name == documentName {
                                            
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
    
    func shareASubject(subjectName: String) {
        
        self.subjectCtrl.fetchSubject { (fetchedSubjects, error) in
            print("subject error: \(error) -- count: \(fetchedSubjects.count)")
            for subject in fetchedSubjects {
                print("sss \(subject.name)")
                
                if subject.name == subjectName {
                    self.sharingCtrl.createCloudSharingController(forSubject: subject,
                                                                  withShareOption: TKShareOption.addParticipant,
                                                                  completion: { (sharingViewCtrl, error) in
                                                                    print("Sharing Errors: \(error)")
                                                                    if let sharingViewCtrl = sharingViewCtrl {
                                                                        self.present(sharingViewCtrl, animated: true)
                                                                    }
                    })
                }
                
            }
        }
    }
    
}
