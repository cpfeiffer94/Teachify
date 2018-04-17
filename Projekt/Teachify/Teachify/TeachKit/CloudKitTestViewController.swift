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

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    @IBAction func doSomethingAction(_ sender: UIButton) {
//        let student1 = TKStudent(firstname: "Philipp", lastname: "Knoblauch", email: "email")
//        let student2 = TKStudent(firstname: "Patrick", lastname: "Niepel", email: "email")
//        let student3 = TKStudent(firstname: "Marcel", lastname: "Hagmann", email: "email")
        
//        let subject = TKSubject(name: "Englisch", color: TKColor.red)
//
//        classCtrl.fetchClasses { (fetchedClasses, error) in
//            for fetchedClass in fetchedClasses {
//                if fetchedClass.name == "8c" {
////                    self.subjectCtrl.add(subject: subject, toTKClass: fetchedClass, completion: { (fetchedSubject, error) in
//////                        print("Fetchi Fetch: \(fetchedSubject) -- \(error)")
////                    })
//
//                    self.subjectCtrl.fetchSubject(forClass: fetchedClass, completion: { (fetchedSubjects, error) in
//                        print("--> \(fetchedSubjects) -- \(error)")
//                        for var subject in fetchedSubjects {
////                            subject.name = "Heeeellloo Update Subject Name :)"
////                            self.subjectCtrl.update(subject: subject, completion: { (updatedSubject, error) in
////                                print("Worked!!!")
////                            })
//                            self.subjectCtrl.delete(subject: subject, completion: { (error) in
//                                print("DELETION ERROR: \(error)")
//                            })
//                        }
//                    })
//
//                }
//            }
//        }
        
        let student = TKStudent(firstname: "Name", lastname: "Student", email: "student@@@@@Generic.com")
        
        teacherCtrl.create(student: student) { (updatedStudent, error) in
            guard let updatedStudent = updatedStudent else { return }

            self.classCtrl.fetchClasses(completion: { (fetchedClasses, error) in
                for fetchedClass in fetchedClasses {
                    if fetchedClass.name == "9a" {
                        self.teacherCtrl.add(student: updatedStudent, toTKClass: fetchedClass, completion: { (studentWithClass, error) in

                        })
                    }
                }
            })
        }
        
    }
    
}
