//
//  GameCardModel.swift
//  Teachify
//
//  Created by Christian Pfeiffer on 12.04.18.
//  Copyright © 2018 Christian Pfeiffer. All rights reserved.
//

import UIKit

class TKModelSingleton {
    
    static let sharedInstance = TKModelSingleton()
    fileprivate var data : [GameInformationItem] = []
    fileprivate var downloadedClasses : [TKClass] = []
//    fileprivate var downloadedSubjects : [[TKSubject]] = []
//    fileprivate var downloadedDocuments : [[TKDocument]] = []
//    fileprivate var downloadedExercises : [[TKExercise]] = []
//
    private init (){}
}


class TKFetchController: NSObject {
    fileprivate var TKFetchedDataModel = TKModelSingleton.sharedInstance
    var TKExerciseCtrl : TKExerciseController = TKExerciseController()
    var TKDocumentCtrl : TKDocumentController = TKDocumentController()
    var TKSubjectCtrl : TKSubjectController = TKSubjectController()
    var TKClassCtrl : TKClassController = TKClassController()
    var TKTeacherCtrl : TKTeacherController = TKTeacherController()
    
    
    func fetchDatabase(aRank rank : TKRank) {
        TKFetchedDataModel.downloadedClasses = []
        
        setupFetchController(aRank: rank)
        
        fetchClassesFromTK()
    }
    
//    Initialisation for TKControllers
    fileprivate func setupFetchController(aRank rank : TKRank){
        TKClassCtrl.initialize(withRank: rank) { (succeed) in
            print("Class init --> \(succeed)")
        }
        
        TKTeacherCtrl.initialize(withRank: rank) { (succeed) in
            print("Teacher init --> \(succeed)")
        }
        
        TKSubjectCtrl.initialize(withRank: rank) { (succeed) in
            print("Subject init --> \(succeed)")
        }
        
        TKDocumentCtrl.initialize(withRank: rank) { (succeed) in
            print("Document init --> \(succeed)")
        }
        
        TKExerciseCtrl.initialize(withRank: rank) { (succeed) in
            print("Exercise init --> \(succeed)")
        }
        
//        TKSharingCtrl = TKShareController(view: self.view)
    }
    
//    Convert TKDocuments to GameCardModel Items
    func updateGamesList(with documents: [TKDocument]) {
        TKFetchedDataModel.data = []
            for document in documents {
                addGame(name: document.name, typ: "FollowTheOrder", deadline: document.deadline, subject: "Mathe", tries: 3)
            }
        
    }
    
///    Debug Print after Data is downloaded.
    func debugPrintAfterFetch () {
        for myclass in TKFetchedDataModel.downloadedClasses {
            print("Downloaded Class: \(myclass.name) DOwnload Subject: \(myclass.subjects.last!.name)" +
                "Download Documents: \(myclass.subjects.last!.documents.last!.name)" +
                "Downloaded Excercise: \(myclass.subjects.last!.documents.last!.exercises.last!.name)")
        }

        
    }
    
///    Downloads all TKClasses from the Cloud and starts fetching all associated Subjects to the Singleton
    func fetchClassesFromTK() {
        TKClassCtrl.fetchClasses(withFetchSortOptions: [.name]) { (fetchedClasses,error) in
            if let error = error{
                print("Failed fetching Classes from TK! \(error)")
                return
            }
            else {
                self.TKFetchedDataModel.downloadedClasses = fetchedClasses
                self.TKFetchedDataModel.downloadedClasses.forEach({ (aClass) in
                    self.fetchSubjectsForClassFromTK(mytkclass: aClass)
                })
    
                print("Fetched \(fetchedClasses.count) Classes from TK sucessfully")
            }
        }
    }
    
///    Downloads all Subjects associated to the parameter TKClass and starts fetching all associated Documents to the Singleton
    func fetchSubjectsForClassFromTK(mytkclass : TKClass) {
        TKSubjectCtrl.fetchSubject(forClass: mytkclass, withFetchSortOptions: [.name]) { (fetchedSubjects, error) in
            if let error = error {
                print("Failed fetching Subject from TK! class:" + mytkclass.recordTypeID! + "with Error Message: \(error)")
                return
            }
         
            let myClassIndex = self.TKFetchedDataModel.downloadedClasses.index(where: { $0.record == mytkclass.record })
            
            if let myClassIndex = myClassIndex
            {
                self.TKFetchedDataModel.downloadedClasses[myClassIndex].append(subjects: fetchedSubjects)
                self.TKFetchedDataModel.downloadedClasses[myClassIndex].subjects
                    .forEach({ [unowned self] (aSubject) in
                        self.fetchDocumentsForSubject(subject: aSubject, in: mytkclass)
                    })
            }
            
            
        }

    }
    
///    Downloads all Documents associated to the parameter Subject and starts fetching all associated Exercises to the Singleton
    func fetchDocumentsForSubject(subject : TKSubject, in tkClass: TKClass) {
        TKDocumentCtrl.fetchDocuments(forSubject: subject, withFetchSortOptions: [.name]) { (fetchedDocuments, error) in
            if let error = error {
                print("Failed fetching Documents from TK! Subjects:" + subject.name + "with Error Message: \(error)")
                return
            }
           
            let myClassIndex = self.TKFetchedDataModel.downloadedClasses.index(where: { $0.record == tkClass.record })
            
            guard let classIndex = myClassIndex else {return}
            
            let mySubjectIndex = self.TKFetchedDataModel.downloadedClasses[classIndex].subjects.index(where: {$0.record == subject.record})
            
            if let subjectIndex = mySubjectIndex
            {
                self.TKFetchedDataModel.downloadedClasses[classIndex].subjects[subjectIndex].documents.append(contentsOf: fetchedDocuments)
                self.TKFetchedDataModel.downloadedClasses[classIndex].subjects[subjectIndex].documents
                    .forEach({ [unowned self] (aDocument) in
                        self.fetchExercises(for: aDocument, in: tkClass, with: subject)
                    })
            }
            
                DispatchQueue.main.async { // very nice DispatchQueue
                    self.updateGamesList(with: fetchedDocuments)
                }
            }
        }
    
    
/// Downloads all Exercises associated to the parameter Document
    func fetchExercises(for document : TKDocument, in tkClass: TKClass, with tkSubject: TKSubject) {
        TKExerciseCtrl.fetchExercises(forDocument: document, withFetchSortOptions: [.name]) { (fetchedExercises, error) in
            if let error = error {
                print("Failed fetching Exercises from TK! Subjects:" + document.name + "with Error Message: \(error)")
                return
            }
           
            let myClassIndex = self.TKFetchedDataModel.downloadedClasses.index(where: { $0.record == tkClass.record })
            
            guard let classIndex = myClassIndex else {return}
            
            let mySubjectIndex = self.TKFetchedDataModel.downloadedClasses[classIndex].subjects.index(where: {$0.record == tkSubject.record})
            
            guard let subjectIndex = mySubjectIndex else {return}
            
            let myDocumentIndex = self.TKFetchedDataModel.downloadedClasses[classIndex].subjects[subjectIndex].documents.index(where: {$0.record == document.record})
            
            if let documentIndex = myDocumentIndex
            {
                self.TKFetchedDataModel.downloadedClasses[classIndex].subjects[subjectIndex].documents[documentIndex].exercises.append(contentsOf: fetchedExercises)
            }

                self.debugPrintAfterFetch()
            }
        }
}

extension TKFetchController{
    
///    adding a GameInformationItem to the gameCardModel for the StudentMainMenuCardView notifying the VC to reload the Collectionitems.
    func addGame(name : String, typ : String, deadline : Date?, subject : String, tries : Int) {
        let tempGameInformation = GameInformationItem(name: name, typ: typ, deadline: deadline, subject: subject, tries: tries)
        
        TKFetchedDataModel.data.append(tempGameInformation)
        
        NotificationCenter.default.post(name: .reloadGameCards , object: nil)
    }
    
///    Resetting the gameCardModel
    func resetGames(){
        TKFetchedDataModel.data = []
        NotificationCenter.default.post(name: .reloadGameCards , object: nil)
    }
    
///    returns the number of Items in the gameCardModel
    func getGamesCount() -> Int {
        return TKFetchedDataModel.data.count
    }
    
    func getGame(forIndex : Int) -> GameInformationItem {
        return TKFetchedDataModel.data[forIndex]
    }
    
/* For Queries in the already fetched Model */
    func getClassForName(queryName : String) -> [TKClass]{
        var resultTKClasses : [TKClass] = []
        for myclass in TKFetchedDataModel.downloadedClasses {
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
    
    
}
