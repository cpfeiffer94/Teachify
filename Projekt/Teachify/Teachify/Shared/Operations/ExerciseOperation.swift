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
    
    override init() {
        super.init()
        exerciseCtrl.initialize(withRank: .teacher) { (succeed) in
            print("Exercise init --> \(succeed)")
        }
    }
    
    
    override func execute() {
        print("Fetch exercises started")
        if documents.count == 0 {
            print("Fetch excercises finished documents=0")
            finish()
            return
        }
        for (index,document) in documents.enumerated() {
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
                
                let mySubjectIndex = self.getSubjectIndex(for: document, with: classIndex)
                
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
                    }
                }
                
                
            }
            
        }
        
    }
    
    //MARK: Index Methods
    
    func getSubjectIndex(for document: TKDocument, with classIndex: Int? = nil) -> Int? {
        
        var aClassIndex = classIndex
        
        if classIndex == nil {
            aClassIndex = TKModelSingleton.sharedInstance.downloadedClasses.index(where:{ $0.subjects.first?.subjectID == document.subjectID })
        }
        
        guard let classIndex = aClassIndex else {return nil}
        
        return TKModelSingleton.sharedInstance.downloadedClasses[classIndex].subjects.index(where:{ $0.subjectID == document.subjectID })
        
    }
}

