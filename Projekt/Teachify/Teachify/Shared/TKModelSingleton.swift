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
    fileprivate var downloadedSubjects : [[TKSubject]] = []
    fileprivate var downloadedDocuments : [[TKDocument]] = []
    fileprivate var downloadedExercises : [[TKExercise]] = []
    
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
        TKFetchedDataModel.downloadedSubjects = []
        TKFetchedDataModel.downloadedDocuments = []
        TKFetchedDataModel.downloadedExercises = []
        
        setupFetchController(aRank: rank)
        
        fetchClassesFromTK()
    }
    
//    Initialisation for TKControllers
    func setupFetchController(aRank rank : TKRank){
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
    func updateGamesList() {
        TKFetchedDataModel.data = []
        for mydocuments in TKFetchedDataModel.downloadedDocuments {
            for document in mydocuments {
                addGame(name: document.name, typ: "FollowTheOrder", deadline: document.deadline, subject: "Mathe", tries: 3)
            }
        }
    }
    
//    Debug Print all downloaded Data.
    func debugPrintAfterFetch () {
        for myclass in TKFetchedDataModel.downloadedClasses {
            print("Downloaded Class:" + myclass.name)
        }
        
        for mysubjects in TKFetchedDataModel.downloadedSubjects {
            for subject in mysubjects{
                print("Downloaded Subject:" + subject.name)
            }
        }
        
        for mydocuments in TKFetchedDataModel.downloadedDocuments {
            for document in mydocuments {
                print("Downloaded Document:" + document.name)
            }
        }
        
        for myexercises in TKFetchedDataModel.downloadedExercises {
            for exercies in myexercises {
                print("Downloaded Exercise: " + exercies.name)
            }
        }
        
    }
    
//    Downloads all TKClasses from the Cloud and starts fetching all associated Subjects to the Singleton
    func fetchClassesFromTK() {
        TKClassCtrl.fetchClasses(withFetchSortOptions: [.name]) { (fetchedClasses,error) in
            if error != nil {
                print("Failed fetching Classes from TK!" + error.debugDescription)
            }
            else {
                self.TKFetchedDataModel.downloadedClasses = fetchedClasses
                for myclass in fetchedClasses {
                    self.fetchSubjectsForClassFromTK(mytkclass: myclass)
                }
                print("Fetched \(fetchedClasses.count) Classes from TK sucessfully")
            }
        }
    }
    
//    Downloads all Subjects associated to the parameter TKClass and starts fetching all associated Documents to the Singleton
    func fetchSubjectsForClassFromTK(mytkclass : TKClass) {
        TKSubjectCtrl.fetchSubject(forClass: mytkclass, withFetchSortOptions: [.name]) { (fetchedSubjects, error) in
            if error != nil {
                print("Failed fetching Subject from TK! class:" + mytkclass.recordTypeID! + "with Error Message: " + error.debugDescription)
            }
            else {
                self.TKFetchedDataModel.downloadedSubjects.append(fetchedSubjects)
                for mysubject in fetchedSubjects{
                    self.fetchDocumentsForSubjectFromTK(mytksubject: mysubject)
                    }
                print("Fetched \(self.TKFetchedDataModel.downloadedSubjects.count) Subjects from TK sucessfully")
            }
        }
    }
    
//    Downloads all Documents associated to the parameter Subject and starts fetching all associated Exercises to the Singleton
    func fetchDocumentsForSubjectFromTK(mytksubject : TKSubject) {
        TKDocumentCtrl.fetchDocuments(forSubject: mytksubject, withFetchSortOptions: [.name]) { (fetchedDocuments, error) in
            if error != nil {
                print("Failed fetching Documents from TK! Subjects:" + mytksubject.name + "with Error Message: " + error.debugDescription)
            }
            else {
                self.TKFetchedDataModel.downloadedDocuments.append(fetchedDocuments)
                for mydocument in fetchedDocuments{
                    self.fetchExercisesForDocumentFromTK(mytkdocument: mydocument)
                }
                print("Fetched \(self.TKFetchedDataModel.downloadedDocuments.count) Documents from TK sucessfully")
                
                DispatchQueue.main.async { // very nice DispatchQueue
                    self.updateGamesList()
                }
            }
        }
    }
    
// Downloads all Exercises associated to the parameter Document
    func fetchExercisesForDocumentFromTK(mytkdocument : TKDocument) {
        TKExerciseCtrl.fetchExercises(forDocument: mytkdocument, withFetchSortOptions: [.name]) { (fetchedExercises, error) in
            if error != nil {
                print("Failed fetching Exercises from TK! Subjects:" + mytkdocument.name + "with Error Message: " + error.debugDescription)
            }
            else {
                self.TKFetchedDataModel.downloadedExercises.append(fetchedExercises)
                print("Fetched \(self.TKFetchedDataModel.downloadedExercises.count) Exercises from TK sucessfully")
                self.debugPrintAfterFetch()
            }
        }
    }
    
//    adding a GameInformationItem to the gameCardModel for the StudentMainMenuCardView notifying the VC to reload the Collectionitems.
    func addGame(name : String, typ : String, deadline : Date?, subject : String, tries : Int) {
        let tempGameInformation = GameInformationItem(name: name, typ: typ, deadline: deadline, subject: subject, tries: tries)
        
        TKFetchedDataModel.data.append(tempGameInformation)
        
        NotificationCenter.default.post(name: .reloadGameCards , object: nil)
    }
    
//    Resetting the gameCardModel
    func resetGames(){
        TKFetchedDataModel.data = []
        NotificationCenter.default.post(name: .reloadGameCards , object: nil)
    }
    
//    returns the number of Items in the gameCardModel
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
