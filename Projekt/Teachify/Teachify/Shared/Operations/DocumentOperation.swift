//
//  DocumentOperation.swift
//  Teachify
//
//  Created by Bastian Kusserow on 23.05.18.
//  Copyright © 2018 Christian Pfeiffer. All rights reserved.
//

import Foundation

class DocumentOperation : BaseOperation {
    
    private var documentCtrl = TKDocumentController()
    var subjects = [TKSubject]()
    
    override init() {
        super.init()
        documentCtrl.initialize(withRank: .teacher) {_ in
            print("Document init --> true")
        }
    }
    
    override func execute() {

        for (index,subject) in subjects.enumerated() {
            documentCtrl.fetchDocuments(forSubject: subject, withFetchSortOptions: [.name]) {(fetchedDocuments, error) in
                if let error = error {
                    print("Failed fetching Documents from TK! Subjects:" + subject.name + "with Error Message: \(error)")
                    self.finish()
                    return
                }
                
                let myClassIndex = TKModelSingleton.sharedInstance.downloadedClasses.index(where: { $0.classID == subject.classID })
                
                guard let classIndex = myClassIndex else {
                    self.finish()
                    return
                    
                }
                
                let mySubjectIndex = TKModelSingleton.sharedInstance.downloadedClasses[classIndex].subjects.index {$0.subjectID == subject.subjectID}
                
                if let subjectIndex = mySubjectIndex
                {
                    TKModelSingleton.sharedInstance.downloadedClasses[classIndex].subjects[subjectIndex].documents.append(contentsOf: fetchedDocuments)
                    if self.subjects.count-1 == index {
                         print("Fetch documents finished")
                        self.finish()
                    }
                    
                }
                self.finish()
            }}
        if subjects.count == 0 {
            finish()
        }
    }
}
