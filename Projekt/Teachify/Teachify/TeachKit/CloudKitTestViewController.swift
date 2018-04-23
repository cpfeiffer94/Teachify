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

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    @IBAction func doSomethingAction(_ sender: UIButton) {
        
        exerciseCtrl.fetchExercises { (fetchedExercises, error) in
            print("error: \(error) - \(fetchedExercises.count)")
            
            for var exercise in fetchedExercises {
                exercise.name = "Aufgabe XXX"
                exercise.deadline = Date()
                
//                self.exerciseCtrl.update(exercise: exercise, completion: { (updatedExercise, error) in
//                    print("error: \(error) - \(updatedExercise?.name)")
//                })
                self.exerciseCtrl.delete(exercise: exercise, completion: { (error) in
                    print("Error: \(error)")
                })
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
