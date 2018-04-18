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

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    @IBAction func doSomethingAction(_ sender: UIButton) {
        
        // CREATE SUBJECT
//        let subject = TKSubject(name: "Englisch", color: .red)
//        classCtrl.fetchClasses { (fetchedClasses, error) in
//            for fetchedClasse in fetchedClasses {
//                if fetchedClasse.name == "9a" {
//                    self.subjectCtrl.add(subject: subject, toTKClass: fetchedClasse, completion: { (updatedSubject, error) in
//                        print("error: \(error) -- \(updatedSubject)")
//                    })
//                }
//            }
//        }
        
        // FETCH SUBJECTS
//        classCtrl.fetchClasses { (fetchedClasses, error) in
//            for fetchedClasse in fetchedClasses {
//                self.subjectCtrl.fetchSubject(forClass: fetchedClasse, completion: { (fetchedSubjects, error) in
//                    for subject in fetchedSubjects {
//                        print("\(fetchedClasse.name) --- \(subject.name) - \(subject.color)")
//                    }
//                })
//            }
//        }
        
        //Create Documents
        
        let doc = TKDocument(name: "IfSätze", deadline: Date())
        subjectCtrl.fetchSubject(forClass: nil) { (fetchedSubjects, error) in
            for fetchedSubject in fetchedSubjects {
                if fetchedSubject.name == "Deutsch" {
                    self.documentCtrl.add(document: doc, toSubject: fetchedSubject, completion: { (addedDoc, error) in
                        print("Subject \(fetchedSubject.name) Doc \(addedDoc?.name) -- error: \(error)")
                    })
                }
            }
        }
        
//        classCtrl.fetchClasses { (classes, error) in
//            for c in classes {
//                self.teacherCtrl.fetchStudents(forTKClass: c) { (students, error) in
//                    for student in students {
//                        print("Klasse: \(c.name) ---- \(student.firstname)")
//                    }
//                }
//            }
//        }
        
//        classCtrl.fetchClasses { (fetchedClasses, error) in
//            for c in fetchedClasses {
//                self.subjectCtrl.fetchSubject(forClass: c, completion: { (fetchedSubjects, error) in
//                    print(fetchedSubjects)
//                    for var subj in fetchedSubjects {
//                        if subj.name == "Englisch" {
//                            subj.name = "Deutsch"
//                            self.subjectCtrl.update(subject: subj, completion: { (updatedSubject, error) in
//                                print("Worked")
//                            })
//                        }
//                    }
//                })
//            }
//        }
        
        
//        teacherCtrl.fetchStudents(forTKClass: nil) { (students, error) in
//
//            for student in students {
//                print("\(student.firstname)")
//            }
//        }
        
        
        
    }
    
}
