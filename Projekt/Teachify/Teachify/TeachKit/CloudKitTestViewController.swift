//
//  CloudKitTestViewController.swift
//  Teachify
//
//  Created by Marcel Hagmann on 13.04.18.
//  Copyright © 2018 Christian Pfeiffer. All rights reserved.
//

import UIKit

class CloudKitTestViewController: UIViewController {
    
    var classCtrl = TKClassController()
    var teacherCtrl = TKTeacherController()
    var subjectCtrl = TKSubjectController()
    var documentCtrl = TKDocumentController()
    var exerciseCtrl = TKExerciseController()
    var sharingCtrl: TKShareController!

    override func viewDidLoad() {
        super.viewDidLoad()

        sharingCtrl = TKShareController(view: self.view)
    }

    @IBAction func doSomethingAction(_ sender: UIButton) {
        
//        classCtrl.fetchClasses(withFetchSortOptions: [.name]) { (fetchedClasses, error) in
//            print("error: \(error)")
//            for fetchedClass in fetchedClasses {
//                print(fetchedClass.name)
//            }
//        }
//
//
//        exerciseCtrl.fetchExercises(forDocument: nil, withFetchSortOptions: [TKFetchSortOption.name]) { (exercises, error) in
//            if error == nil {
//                for exercise in exercises {
//                    exercise.data
//                }
//            }
//        }
//
//
//        let ex = TKExercise(name: "Aufgabe 1a)", deadline: nil, type: .wordTranslation, data: "json")
        
        let mhClass = TKClass(name: "MH Class")
        let subject = TKSubject(name: "MH Subject 1", color: TKColor.yellow)
        
        classCtrl.create(tkClass: mhClass) { (uploadedClass, error) in
            self.subjectCtrl.add(subject: subject, toTKClass: uploadedClass!, completion: { (uploadedSubject, error) in
                print("Everything went okay :)")
            })
        }
        
//        subjectCtrl.fetchSubject { (fetchedSubjects, error) in
//            for subject in fetchedSubjects {
//                if subject.name == "Deutsch" {
//                    print("Found \(subject.name)")
//
//                    self.sharingCtrl.createCloudSharingController(forSubject: subject, withShareOption: .addParticipant) { sharingVC, error in
//
//                        if let sharingVC = sharingVC {
//                            self.present(sharingVC, animated: true)
//                        }
//
//                    }
//
//                }
//            }
//        }
        
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
    
}
