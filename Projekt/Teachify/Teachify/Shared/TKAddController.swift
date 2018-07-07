//
//  TKAddController.swift
//  Teachify
//
//  Created by Bastian Kusserow on 07.07.18.
//  Copyright © 2018 Christian Pfeiffer. All rights reserved.
//

import Foundation


class TKAddController {
    
    private let model = TKModelSingleton.sharedInstance
    
    private func addClassToModel(aClass: TKClass){
        TKModelSingleton.sharedInstance.downloadedClasses.append(aClass)
    }
    
    private func addSubject(_ subject: TKSubject, toClass: TKClass){
        guard let index = self.model.downloadedClasses.index(where: {$0.classID==toClass.classID}) else {return}
        self.model.downloadedClasses[index].subjects.append(subject)
    }
    
    func addSubject(newSubject: TKSubject, toClass: TKClass, completion: @escaping ()->()) {
        var subjectCtrl = TKSubjectController()
        subjectCtrl.initialize(withRank: .teacher) { (success) in
            return
        }
        subjectCtrl.add(subject: newSubject, toTKClass: toClass) { (uploadedSubject, error) in
            if let error = error{
                print(error)
            }
            if let uploadedSubject = uploadedSubject {
                DispatchQueue.main.async {
                    self.addSubject(uploadedSubject, toClass: toClass)
                    completion()
                }
            }
        }
        
    }
    
    func addClass(class: TKClass, completion: @autoclosure @escaping () -> ()) {
        var classCtrl = TKClassController()
        classCtrl.initialize(withRank: .teacher) { (error) in
            if let error = error {
                print(error.localizedDescription)
                return
            }
            
        }
            classCtrl.create(tkClass: `class`) {
            (uploadedClass, error) in
            if let error = error{
                print(error)
            }
            if let addedClass = uploadedClass {
                self.addClassToModel(aClass: addedClass)
                completion()
            }
            }
            
        
    }
}
