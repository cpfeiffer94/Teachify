//
//  TKDownloadController.swift
//  Teachify
//
//  Created by Bastian Kusserow on 03.05.18.
//  Copyright © 2018 Christian Pfeiffer. All rights reserved.
//

import Foundation

struct TKDownloadController {
    
    typealias CompletionHandler = ([TKClass]?, [TKSubject]?) -> ()
    
    func loadData(completion: @escaping CompletionHandler){
        let classController = TKClassController()
        let subjectController = TKSubjectController()
        classController.fetchClasses(withFetchSortOptions: [.name]) { (classes, error) in
            if let error = error {
                print("Error fetching classes \(error)")
            }
            
            if !classes.isEmpty {
                subjectController.fetchSubject(forClass: classes.first!, withFetchSortOptions: [.name], completion: { (subjects, error) in
                    guard let _ = error else {return}
                    
                    completion(classes, subjects)
                })
            }
            
            }
            
        }
        
}
