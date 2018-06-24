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
//    var solutionsCtrl: TKSolutionController!
    var userCtrl: TKUserProfileController!

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
            print("Class init --> \(String(describing: succeed))")
        }
        
        teacherCtrl = TKTeacherController()
        teacherCtrl.initialize(withRank: rank) { (succeed) in
            print("Teacher init --> \(String(describing: succeed))")
        }
        
        subjectCtrl = TKSubjectController()
        subjectCtrl.initialize(withRank: rank) { (succeed) in
            print("Subject init --> \(String(describing: succeed))")
        }
        
        documentCtrl = TKDocumentController()
        documentCtrl.initialize(withRank: rank) { (succeed) in
            print("Document init --> \(String(describing: succeed))")
        }
        
        exerciseCtrl = TKExerciseController()
        exerciseCtrl.initialize(withRank: rank) { (succeed) in
            print("Exercise init --> \(String(describing: succeed))")
        }
        
//        solutionsCtrl = TKSolutionController()
//        solutionsCtrl.initialize(withRank: rank) { (succeed) in
//            print("Solution init --> \(succeed)")
//        }
        
        userCtrl = TKUserProfileController()
        
        sharingCtrl = TKShareController(view: self.view)
    }
    
    // MARK: - IBActions
    
    @IBAction func shareSubjectAction(_ sender: UIButton) {
        let subjectNameToShare = "mhTEST_subject"
        shareASubject(subjectName: subjectNameToShare)
    }
    
    @IBAction func stopSharing(_ sender: UIButton) {
        let subjectNameToShare = "SubjectName17_123"
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
        self.subjectCtrl.fetchSubject { (fetchedSubjects, error) in
            print("Number of Shared Subjects: \(fetchedSubjects.count)")
            for subject in fetchedSubjects {
                print("Shared Subject Name: \(subject.name)")
            }
        }
    }
    
    @IBAction func fetchAllExercises(_ sender: UIButton) {
        self.exerciseCtrl.fetchExercises { (fetchedExercises, error) in
            print("Number of Shared Exercises: \(fetchedExercises.count)")
            for exercise in fetchedExercises {
                print("Shared Exercise Name: \(exercise.name)")
            }
        }
    }
    
    @IBAction func createNewDummyContent(_ sender: UIButton) {
        let alert = UIAlertController(title: "Create",
                                     message: "Hier wird automatisch ein Class, Subject, Document und Exercise Objekt erstellt und in die Cloud geladen.", preferredStyle: .alert)
        alert.addTextField(configurationHandler: nil)
        alert.addAction(UIAlertAction(title: "Abbrechen", style: .cancel, handler: nil))
        alert.addAction(UIAlertAction(title: "Create", style: .default, handler: { (_) in
            let text = alert.textFields![0].text!
            self.create(className: "\(text)_class", subjectName: "\(text)_subject",
                documentName: "\(text)_document", exerciseName: "\(text)_exercise")
        }))
        present(alert, animated: true)
    }
    
    @objc func linkInputDidChange() {
        if let inputString = linkToShareTextField.text {
            let qrCode = createQRCode(string: inputString)
            sharingQRImageView.image = qrCode
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
        let tkExercise = TKExercise(name: exerciseName, deadline: nil, type: .mathpiano, data: "Daaaata")
        
        self.classCtrl.create(tkClass: tkClass) { (createdClass, error) in
            print("Class Error: \(String(describing: error))")
            guard let createdClass = createdClass else { return }
            
            self.subjectCtrl.add(subject: tkSubject, toTKClass: createdClass, completion: { (createdSubject, error) in
                print("Subject Error: \(String(describing: error))")
                guard let createdSubject = createdSubject else { return }
                
                self.documentCtrl.add(document: tkDocument, toSubject: createdSubject, completion: { (createdDocument, error) in
                    print("Document Error: \(String(describing: error))")
                    guard let createdDocument = createdDocument else { return }
                    
                    self.exerciseCtrl.create(exercise: tkExercise, toDocument: createdDocument, completion: { (createdExercise, error) in
                        print("Exercise Error: \(String(describing: error))")
                    })
                    
                })
                
            })
            
        }
    }
    
    func createExercise() {
        let className = "17a"
        let subjectName = "Subject17"
        let documentName = "Document17"
        
        let exercise = TKExercise(name: "Aufgabe17", deadline: nil, type: .mathpiano, data: "Hello das ist die Dataaaaaa!")
        
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
                                                print("error: \(error) -- \(String(describing: createdExercise?.name))")
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
            print("subject error: \(String(describing: error)) -- count: \(fetchedSubjects.count)")
            for subject in fetchedSubjects {
                print("sss \(subject.name)")
                
                if subject.name == subjectName {
                    self.sharingCtrl.createCloudSharingController(forSubject: subject,
                                                                  withShareOption: TKShareOption.addParticipant,
                                                                  completion: { (sharingViewCtrl, error) in
                                                                    print("Sharing Errors: \(String(describing: error))")
                                                                    if let sharingViewCtrl = sharingViewCtrl {
                                                                        self.present(sharingViewCtrl, animated: true)
                                                                    }
                    })
                }
                
            }
        }
    }
    
    @IBAction func solutionTestAction(_ sender: UIButton) {
        exerciseCtrl.fetchExercises { (allExercises, error) in
            for exercise in allExercises {
                print(exercise.name)
            }
        }
    }
    
//    func fetchAllSolutions() {
//        solutionsCtrl.fetchSolutions { (allSolutions, error) in
//            for solution in allSolutions {
//                print(solution.userSolution)
//            }
//        }
//    }
//
//    func deleteAllSolutions() {
//        solutionsCtrl.fetchSolutions { (allSolutions, error) in
//            for solution in allSolutions {
//                self.solutionsCtrl.delete(solution: solution, completion: { (error) in
//                    print("solution-delete-error: \(error)")
//                })
//            }
//        }
//    }
//
//    func updateSoltution() {
//        solutionsCtrl.fetchSolutions { (allSolutions, error) in
//            for var solution in allSolutions {
//                solution.userSolution = "Muhahahahahahahaha :)))))))"
//                self.solutionsCtrl.update(solution: solution, completion: { (updatedSolution, error) in
//                    print("error: \(error)")
//                })
//            }
//        }
//    }
//
//    func addSolution() {
//        CKContainer.default().fetchUserRecordID { (userRecordID, error) in
//            if let userRecordID = userRecordID {
//                let userID = userRecordID.recordName
//                let solution = TKSolution(userSolution: "This is my solution :)", status: .correct, owner: userID)
//                let test2 = TKSolution2(status: .correct, userSolution: "This is my solution :)))))", ownerID: userID)
//
//                self.exerciseCtrl.fetchExercises(completion: { (allExercises, error) in
//                    for var exercise in allExercises {
//                        if exercise.name == "mhTEST_exercise" {
//
//
//                            exercise.solutions = [test2]
//
//                            self.exerciseCtrl.update(exercise: exercise, completion: { (newExercise, error) in
//                                print("---- > error: \(error) - \(newExercise)")
//                            })
//
//                        }
//                    }
//                })
//
//            } else {
//                print("Solution upload error - id fetching failed: \(error)")
//            }
//        }
//    }
    
    
    @IBAction func userProfileAction(_ sender: UIButton) {
//        userCtrl.fetchUserProfile { (user, error) in
//            guard var user = user else { return }
//            user.firstname = "Vorname"
//            user.lastname = "Nachname"
//            user.image = UIImage(named: "Inder")
//
//            self.userCtrl.update(user: user, completion: { (updatedUser, error) in
//                print("----> \(updatedUser)")
//            })
//
//        }
        userCtrl.fetchUserProfile { (user, error) in
            guard let user = user else { return }
            DispatchQueue.main.async {
                self.sharingQRImageView.image = user.image
                print("image: \(String(describing: user.image))")
            }
        }
    }
}













