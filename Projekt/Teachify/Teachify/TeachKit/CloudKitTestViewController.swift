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

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    @IBAction func doSomethingAction(_ sender: UIButton) {
//        let tkClass = TKClass(name: "Class Name 123")
//        classCtrl.create(tkClass: tkClass) { (uploadedTKClass, error) in
//            print("uploadedTKClass?.creationDate: \(uploadedTKClass?.creationDate) \(uploadedTKClass?.name) -- \(error)")
//        }
        
//        classCtrl.fetchDirectories { (fetchedClasses, error) in
//            for tkClass in fetchedClasses {
//                if tkClass.name == "TKClass-init-Error" {
//                    var tkClass = tkClass
//                    tkClass.name = "New Name"
//                    self.classCtrl.update(tkClass: tkClass, completion: { (updatedClass, error) in
//                        print("Update - Error: \(error) -- \(updatedClass)")
//                    })
//                }
//
//                if tkClass.name == "8c" {
//                    self.classCtrl.delete(tkClass: tkClass, completion: { (error) in
//                        print("Delete error: \(error)")
//                    })
//                }
//            }
//        }
        
//        let student1 = TKStudent(firstname: "Philipp", lastname: "Knoblauch", email: "email")
//        let student2 = TKStudent(firstname: "Patrick", lastname: "Niepel", email: "email")
//        let student3 = TKStudent(firstname: "Marcel", lastname: "Hagmann", email: "email")
//
//        classCtrl.fetchClasses { (fetchedClasses, error) in
//            for fetchedClass in fetchedClasses {
//                if fetchedClass.name == "7c" {
//                    for student in [student1, student2, student3] {
//                        self.teacherCtrl.add(student: student, toTKClass: fetchedClass, completion: { (student, error) in
//                            print("Add - TKStudent: \(student?.firstname) - ERROR: \(error)")
//                        })
//                    }
//                }
//            }
//        }
        
        
        
        // Student fertig schreiben (Teacher Controller)
        // Einem Student mehrere TKClasse's hinzufügen können
        // Wenn eine Klasse gelöscht wird, schauen welcher Stundent keine Klasse mehr hat und diesen löschen
        
        teacherCtrl.fetchStudents { (students, error) in
            print("teacherCtrl.fetchStudents error: \(error)")
            for student in students {
                print(student.firstname)
            }
        }
        
    }
    
}
