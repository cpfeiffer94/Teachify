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
    var settingsCtrl = TKSettingsController()

    override func viewDidLoad() {
        super.viewDidLoad()

        sharingCtrl = TKShareController(view: self.view)
    }

    @IBAction func doSomethingAction(_ sender: UIButton) {
        let aClass = TKClass(name: "12a")
        let subject = TKSubject(name: "Programmierung", color: TKColor.yellow)
        
        // iPad 2
//        self.subjectCtrl.fetchSubject { (subjects, error) in
//            if let subject.name = "Additionsmathematik 2.0" {
//                self.sharingCtrl.createCloudSharingController(forSubject: subject, withShareOption: .addParticipant, completion: { (viewCtrl, error) in
//                    print("error: \(error)")
//                    if let viewCtrl = viewCtrl {
//                        self.present(viewCtrl, animated: true)
//                    }
//                })
//            }
//        }
        
        // iPad Pro
        subjectCtrl.fetchSubject { (sharedSubjects, error) in
            print(sharedSubjects)
            for subject in sharedSubjects {
                print(subject.name)
            }
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
    
}
