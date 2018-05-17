//
//  GameCardModel.swift
//  Teachify
//
//  Created by Christian Pfeiffer on 12.04.18.
//  Copyright © 2018 Christian Pfeiffer. All rights reserved.
//

import UIKit

//MARK: TKModelSingleton
class TKModelSingleton {
    
    static let sharedInstance = TKModelSingleton()
    fileprivate var data : [GameInformationItem] = []
    fileprivate var downloadedClasses : [TKClass] = []
    private init (){}
}


//############################################
//MARK: TKFetchController
class TKFetchController: NSObject {
    fileprivate var model = TKModelSingleton.sharedInstance
    private var exerciseCtrl : TKExerciseController = TKExerciseController()
    private var documentCtrl : TKDocumentController = TKDocumentController()
    private var subjectCtrl : TKSubjectController = TKSubjectController()
    private var classCtrl : TKClassController = TKClassController()
    private var teacherCtrl : TKTeacherController = TKTeacherController()
    
    private override init() {
        super.init()
    }
    
    init(rank: TKRank){
        super.init()
        model.downloadedClasses = []
        
        setupFetchController(aRank: rank)
    }
    
    
    //    Initialisation for TKControllers
    fileprivate func setupFetchController(aRank rank : TKRank){
        classCtrl.initialize(withRank: rank) { (succeed) in
            print("Class init --> \(succeed)")
        }
        
        teacherCtrl.initialize(withRank: rank) { (succeed) in
            print("Teacher init --> \(succeed)")
        }
        
        subjectCtrl.initialize(withRank: rank) { (succeed) in
            print("Subject init --> \(succeed)")
        }
        
        documentCtrl.initialize(withRank: rank) { (succeed) in
            print("Document init --> \(succeed)")
        }
        
        exerciseCtrl.initialize(withRank: rank) { (succeed) in
            print("Exercise init --> \(succeed)")
        }
        
        //        TKSharingCtrl = TKShareController(view: self.view)
    }
    
    //    Convert TKDocuments to GameCardModel Items
    private func updateGamesList(with documents: [TKDocument]) {
        model.data = []
        for document in documents {
            addGame(name: document.name, typ: "FollowTheOrder", deadline: document.deadline, subject: "Mathe", tries: 3)
        }
        
    }
    
    ///    Debug Print after Data is downloaded.
    private func debugPrintAfterFetch () {
        for myclass in model.downloadedClasses {
            print("Downloaded Class: \(myclass.name) DOwnload Subject: \(myclass.subjects.last?.name)" +
                "Download Documents: \(myclass.subjects.last?.documents.last?.name)" +
                "Downloaded Excercise: \(myclass.subjects.last?.documents.last?.exercises.last?.name)")
        }
        
        
    }
    
    ///    Downloads all TKClasses from the Cloud and starts fetching all associated Subjects to the Singleton
    private func fetchClassesFromTK() {
        classCtrl.fetchClasses(withFetchSortOptions: [.name]) { (fetchedClasses,error) in
            if let error = error{
                print("Failed fetching Classes from TK! \(error)")
                return
            }
            else {
                self.model.downloadedClasses = fetchedClasses
                //                    self.model.downloadedClasses.forEach({ (aClass) in
                //                        self.fetchSubjectsForClassFromTK(mytkclass: aClass)
                //                    })
            }
        }
    }
    
    ///    Downloads all Subjects associated to the parameter TKClass and starts fetching all associated Documents to the Singleton
    private func fetchSubjectsForClassFromTK(classes : [TKClass]) {
        for aClass in classes {
            
            subjectCtrl.fetchSubject(forClass: aClass, withFetchSortOptions: [.name]) { (fetchedSubjects, error) in
                if let error = error {
                    print("Failed fetching Subject from TK! class:" + aClass.recordTypeID! + "with Error Message: \(error)")
                    return
                }
                
                let myClassIndex = self.model.downloadedClasses.index { $0.classID == aClass.classID }
                
                if let myClassIndex = myClassIndex
                {
                    self.model.downloadedClasses[myClassIndex].append(subjects: fetchedSubjects)
                    
                    //                    self.model.downloadedClasses[myClassIndex].subjects
                    //                        .forEach({ [unowned self] (aSubject) in
                    //                            self.fetchDocumentsForSubject(subject: aSubject)
                    //                        })
                    
                    
                }
                
            }
        }
        
    }
    
    ///    Downloads all Documents associated to the parameter Subject and starts fetching all associated Exercises to the Singleton
    private func fetchDocumentsForSubject(subjects : [TKSubject]) {
        
        for subject in subjects {
            documentCtrl.fetchDocuments(forSubject: subject, withFetchSortOptions: [.name]) { (fetchedDocuments, error) in
                if let error = error {
                    print("Failed fetching Documents from TK! Subjects:" + subject.name + "with Error Message: \(error)")
                    return
                }
                
                let myClassIndex = self.model.downloadedClasses.index(where: { $0.classID == subject.classID })
                
                guard let classIndex = myClassIndex else {return}
                
                let mySubjectIndex = self.model.downloadedClasses[classIndex].subjects.index {$0.subjectID == subject.subjectID}
                
                if let subjectIndex = mySubjectIndex
                {
                    self.model.downloadedClasses[classIndex].subjects[subjectIndex].documents.append(contentsOf: fetchedDocuments)
                    
                    //                    self.model.downloadedClasses[classIndex].subjects[subjectIndex].documents
                    //                        .forEach({ [unowned self] (aDocument) in
                    //                            self.fetchExercises(for: aDocument)
                    //                        })
                    
                    
                }
                
                DispatchQueue.main.async { // very nice DispatchQueue
                    self.updateGamesList(with: fetchedDocuments)
                }
            }}
    }
    
    
    /// Downloads all Exercises associated to the parameter Document
    private func fetchExercises(for documents : [TKDocument]) {
        
        for document in documents {
            exerciseCtrl.fetchExercises(forDocument: document, withFetchSortOptions: [.name]) { (fetchedExercises, error) in
                if let error = error {
                    print("Failed fetching Exercises from TK! Subjects:" + document.name + "with Error Message: \(error)")
                    return
                }
                
                let myClassIndex = self.model.downloadedClasses.index(where:{ $0.subjects.first?.subjectID == document.subjectID })
                
                guard let classIndex = myClassIndex else {return}
                
                let mySubjectIndex = self.getSubjectIndex(for: document, with: classIndex)
                
                guard let subjectIndex = mySubjectIndex else {return}
                
                let myDocumentIndex = self.model.downloadedClasses[classIndex].subjects[subjectIndex].documents.index(where: {$0.documentID == document.documentID})
                
                if let documentIndex = myDocumentIndex
                {
                    self.model.downloadedClasses[classIndex].subjects[subjectIndex].documents[documentIndex].exercises.append(contentsOf: fetchedExercises)
                }
                
                self.debugPrintAfterFetch()
            }}
    }
    
    //MARK: Index Methods
    
    func getSubjectIndex(for document: TKDocument, with classIndex: Int? = nil) -> Int? {
        
        var aClassIndex = classIndex
        
        if classIndex == nil {
            aClassIndex = self.model.downloadedClasses.index(where:{ $0.subjects.first?.subjectID == document.subjectID })
        }
        
        guard let classIndex = aClassIndex else {return nil}
        
        return self.model.downloadedClasses[classIndex].subjects.index(where:{ $0.subjectID == document.subjectID })
        
    }
    
    func getClassIndex(for document: TKDocument) -> Int? {
        return 0
    }
}


//#####################################################
//MARK: Zugriffsschicht
extension TKFetchController{
    
    ///    adding a GameInformationItem to the gameCardModel for the StudentMainMenuCardView notifying the VC to reload the Collectionitems.
    func addGame(name : String, typ : String, deadline : Date?, subject : String, tries : Int) {
        let tempGameInformation = GameInformationItem(name: name, typ: typ, deadline: deadline, subject: subject, tries: tries)
        
        model.data.append(tempGameInformation)
        
        NotificationCenter.default.post(name: .reloadGameCards , object: nil)
    }
    
    ///    Resetting the gameCardModel
    func resetGames(){
        model.data = []
        NotificationCenter.default.post(name: .reloadGameCards , object: nil)
    }
    
    ///    returns the number of Items in the gameCardModel
    func getGamesCount() -> Int {
        return model.data.count
    }
    
    func getGame(forIndex : Int) -> GameInformationItem {
        return model.data[forIndex]
    }
    
    /* For Queries in the already fetched Model */
    func getClassForName(queryName : String) -> [TKClass]{
        var resultTKClasses : [TKClass] = []
        for myclass in model.downloadedClasses {
            if myclass.name == queryName{
                resultTKClasses.append(myclass)
            }
        }
        return resultTKClasses
    }
    
    //    func getSubjectsForClassRecord (queryRecord : CKRecord){
    //        var postition : Int
    //
    //
    //    }
    
    func fetchAll() {
        //TODO subjectOperation, classesOperation, documentOperatin, exerciseOperation
        
    }
    
    func fetchClasses(){
        //TODO
    }
    
    func fetchSubjects(for classes : [TKClass]){
        //TODO
    }
    
    func fetchDocuments(for subjects: [TKSubject]){
        //TODO
    }
    
    func fetchExercise(for documents: [TKDocument], notificationName: Notification.Name){
        let exerciseOperation = BlockOperation {
            self.fetchExercises(for: documents)
        }
        exerciseOperation.completionBlock = {
            NotificationCenter.default.post(Notification(name: notificationName))
        }
        let queue = OperationQueue()
        queue.addOperation(exerciseOperation)
    }
    
    
}

extension Notification {
    static var excerciseLoaded = Notification.Name("exerciseLoaded")
}
