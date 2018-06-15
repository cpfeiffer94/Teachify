//
//  SubjectOperation.swift
//  Teachify
//
//  Created by Bastian Kusserow on 23.05.18.
//  Copyright © 2018 Christian Pfeiffer. All rights reserved.
//

import Foundation

class SubjectOperation : BaseOperation {
    
    private var subjectCtrl : TKSubjectController = TKSubjectController()
    private var fetchCtrl : TKFetchController = TKFetchController()
    
    var classes = [TKClass]()
    
    override init(opRank : TKRank) {
        super.init(opRank: opRank)
//        forced Unwrap
        subjectCtrl.initialize(withRank: operationRank!) { (succeed) in
            print("Subject init --> \(succeed)")
        }
    }
    
    override func execute() {
        print("Fetch Subjects started with Rank: \(operationRank)")
        if (operationRank == .teacher){
            for (index,aClass) in classes.enumerated() {
                subjectCtrl.fetchSubject(forClass: aClass, withFetchSortOptions: [.name]) { (fetchedSubjects, error) in
                    if let error = error {
                        print("Failed fetching Subject from TK! class:" + aClass.recordTypeID! + "with Error Message: \(error)")
                        self.finish()
                        return
                    }
                    let myClassIndex = TKModelSingleton.sharedInstance.downloadedClasses.index { $0.classID == aClass.classID }
                    if let myClassIndex = myClassIndex
                    {
                        print("myClassIndex: \(myClassIndex)")
                        TKModelSingleton.sharedInstance.downloadedClasses[myClassIndex].append(subjects: fetchedSubjects)
                        if index == self.classes.count-1{
                            print("Fetch subjects finished")
                            self.finish()
                        }
                    }
                
                }
                }
        if classes.count == 0 {
            finish()
        }
    }
        if (operationRank == .student){
            subjectCtrl.fetchSubject(withFetchSortOptions: [.name]) { (fetchedSubjects,error) in
                if let error = error{
                    print("Failed fetching Subjects \(self.operationRank) from TK! \(error)")
                    self.finish()
                    return
                }
                else {
                    TKModelSingleton.sharedInstance.downloadedSubjects = fetchedSubjects
                    print("Fetch subjects finished (count=\(fetchedSubjects.count))")
                    self.finish()
                }
            }
        }
    }
    
}
