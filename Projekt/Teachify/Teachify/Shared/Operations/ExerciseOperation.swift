//
//  ExerciseOperation.swift
//  Teachify
//
//  Created by Bastian Kusserow on 23.05.18.
//  Copyright © 2018 Christian Pfeiffer. All rights reserved.
//

import Foundation

class ExerciseOperation : BaseOperation {
    
    private var exerciseCtrl : TKExerciseController = TKExerciseController()
    var documents = [TKDocument]()
    
    override init(opRank: TKRank) {
        super.init(opRank: opRank)
        exerciseCtrl.initialize(withRank: opRank) { (succeed) in
            print("Exercise init --> \(succeed) as: \(opRank)" )
        }
    }
    
    
    override func execute() {
        print("Fetch exercises started")
        if documents.count == 0 {
            print("Fetch excercises finished documents is empty!")
            finish()
            return
        }
        
        if operationRank == .teacher {
            for (index,document) in documents.enumerated(){
                exerciseCtrl.fetchExercises(forDocument: document, withFetchSortOptions: [.name]) { (fetchedExercises, error) in
                    if let error = error {
                        print("Failed fetching Exercises from TK! Subjects:" + document.name + "with Error Message: \(error)")
                        self.finish()
                        return
                    }
                    
                    let myClassIndex = TKModelSingleton.sharedInstance.downloadedClasses.index(where:{ $0.subjects.first?.subjectID == document.subjectID })
                    
                    guard let classIndex = myClassIndex else {
                        print("ExcerciseOperation/E: guard class Index")
                        return
                        
                    }
                    
                    let mySubjectIndex = self.getSubjectIndexInClass(for: document, with: classIndex)
                    
                    guard let subjectIndex = mySubjectIndex else {
                        print("ExcerciseOperation/E: guard subject Index")
                        return}
                    
                    let myDocumentIndex = TKModelSingleton.sharedInstance.downloadedClasses[classIndex].subjects[subjectIndex].documents.index(where: {$0.documentID == document.documentID})
                    
                    if let documentIndex = myDocumentIndex
                    {
                        print("ExerciseOperation exercise set")
                        TKModelSingleton.sharedInstance.downloadedClasses[classIndex].subjects[subjectIndex].documents[documentIndex].exercises.append(contentsOf: fetchedExercises)
                        if index == self.documents.count-1{
                            print("Fetch exercises finished")
                            self.finish()
                            return
                        }
                    }
                    
                    
                }
                
            }
        }
        if operationRank == .student {
            for (index,document) in documents.enumerated(){
                exerciseCtrl.fetchExercises(forDocument: document, withFetchSortOptions: [.name]) { (fetchedExercises, error) in
                    if let error = error {
                        print("Failed fetching Exercises from TK! Subjects:" + document.name + "with Error Message: \(error)")
                        self.finish()
                        return
                    }
                    
                    let mySubjectIndex = TKModelSingleton.sharedInstance.downloadedSubjects.index(where:{ $0.subjectID == document.subjectID })
                    
                    guard let subjectIndex = mySubjectIndex else {
                        print("ExcerciseOperation/E: guard subject Index")
                        return
                        
                    }
                    
                    let myDocumentIndex = TKModelSingleton.sharedInstance.downloadedSubjects[subjectIndex].documents.index(where: {$0.documentID == document.documentID})
                    
                    if let documentIndex = myDocumentIndex
                    {
                        print("ExerciseOperation exercise set")
                        TKModelSingleton.sharedInstance.downloadedSubjects[subjectIndex].documents[documentIndex].exercises = fetchedExercises
                        if index == self.documents.count-1{
                            print("Fetch exercises finished")
                            self.finish()
                            return
                        }
                    }
                }
                
            }
        }
        
    }
    
    //MARK: Index Methods
    
    func getSubjectIndexInClass(for document: TKDocument, with classIndex: Int? = nil) -> Int? {
        
        var aClassIndex = classIndex
        
        if classIndex == nil {
            aClassIndex = TKModelSingleton.sharedInstance.downloadedClasses.index(where:{ $0.subjects.first?.subjectID == document.subjectID })
        }
        
        guard let classIndex = aClassIndex else {return nil}
        
        return TKModelSingleton.sharedInstance.downloadedClasses[classIndex].subjects.index(where:{ $0.subjectID == document.subjectID })
        
    }
}

