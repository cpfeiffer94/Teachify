//
//  TKUploadController.swift
//  Teachify
//
//  Created by Bastian Kusserow on 11.06.18.
//  Copyright © 2018 Christian Pfeiffer. All rights reserved.
//

import Foundation

class TKUploadController {
    
    var subjectCtrl = TKSubjectController()
    var documentCtrl = TKDocumentController()
    
    init(with rank: TKRank, notify: Notification.Name? = nil) {
        subjectCtrl.initialize(withRank: rank) { _ in
            print("Initialize success")
        }
        documentCtrl.initialize(withRank: rank) { (_) in
            print("doc Ctrl initialize success")
        }
    }
    
    
    
    
    func uploadDocument(document: TKDocument, for subject: TKSubject) {
        documentCtrl.add(document: document, toSubject: subject) { (document, error) in
            
        }
    }
    
    
    
}
