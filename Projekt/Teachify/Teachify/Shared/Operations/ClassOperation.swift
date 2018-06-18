//
//  ClassOperation.swift
//  Teachify
//
//  Created by Bastian Kusserow on 23.05.18.
//  Copyright © 2018 Christian Pfeiffer. All rights reserved.
//

import Foundation

class ClassOperation : BaseOperation {
    
    private var classCtrl : TKClassController = TKClassController()
    
    override init(opRank : TKRank) {
        super.init(opRank: opRank)
//        Force Unwrap
        classCtrl.initialize(withRank: operationRank!) { (succeed) in
            print("Class init --> \(succeed)")
        }
    }
    
    
    override func execute() {
        if operationRank == .student {
            self.finish()
            return
        } 
        classCtrl.fetchClasses(withFetchSortOptions: [.name]) { (fetchedClasses,error) in
            if let error = error{
                print("Failed fetching Classes from TK! \(error)")
                self.finish()
                return
            }
            else {
                TKModelSingleton.sharedInstance.downloadedClasses = fetchedClasses
                print("Fetch classes finished")
                self.finish()
                return
            }
        }

    }
}
