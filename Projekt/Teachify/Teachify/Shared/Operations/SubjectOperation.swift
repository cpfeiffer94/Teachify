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
    private var countSubjectsIndex = 0
    
    var classes = [TKClass]()
    
    override init(opRank : TKRank) {
        super.init(opRank: opRank)
//        forced Unwrap
        subjectCtrl.initialize(withRank: operationRank!) { (succeed) in
            print("Subject init --> \(succeed)")
            if (succeed == nil){
                self.isInitialized = true
            }
        }
    }
    
    override func execute() {
        if (!isInitialized){
            self.finish()
            return
        }
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
                        print("myClassIndex: \(myClassIndex) Index: \(index)")
                        TKModelSingleton.sharedInstance.downloadedClasses[myClassIndex].append(subjects: fetchedSubjects)
                        if self.countSubjectsIndex == self.classes.count-1{
                            print("Fetch subjects finished")
                            self.finish()
                            return
                        }
                        self.countSubjectsIndex = self.countSubjectsIndex+1
                        print ("New Idx: \(self.countSubjectsIndex)")
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
                    return
                }
            }
        }
    }
    
}
