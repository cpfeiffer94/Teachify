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
    fileprivate var gameCardModel = TKModelSingleton.sharedInstance
    var TKExerciseCtrl : TKExerciseController = TKExerciseController()
    var TKDocumentCtrl : TKDocumentController = TKDocumentController()
    var TKSubjectCtrl : TKSubjectController = TKSubjectController()
    var TKClassCtrl : TKClassController = TKClassController()
    var TKTeacherCtrl : TKTeacherController = TKTeacherController()
//    var TKShareCtrl : TKShareController = TKShareController(view: <#T##UIView#>)
    
    
    func fetchDatabase(aRank rank : TKRank) {
        gameCardModel.downloadedClasses = []
        gameCardModel.downloadedSubjects = []
        gameCardModel.downloadedDocuments = []
        gameCardModel.downloadedExercises = []
        
        setupFetchController(aRank: rank)
        
        fetchClassesFromTK()
    }
    
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
    
    func updateGamesList() {
        gameCardModel.data = []
        for mydocuments in gameCardModel.downloadedDocuments {
            for document in mydocuments {
                addGame(name: document.name, typ: "FollowTheOrder", deadline: document.deadline, subject: "Mathe", tries: 3)
            }
        }
    }
    
    func debugPrintAfterFetch () {
        for myclass in gameCardModel.downloadedClasses {
            print("Downloaded Class:" + myclass.name)
        }
        
        for mysubjects in gameCardModel.downloadedSubjects {
            for subject in mysubjects{
                print("Downloaded Subject:" + subject.name)
            }
        }
        
        for mydocuments in gameCardModel.downloadedDocuments {
            for document in mydocuments {
                print("Downloaded Document:" + document.name)
            }
        }
        
        for myexercises in gameCardModel.downloadedExercises {
            for exercies in myexercises {
                print("Downloaded Exercise: " + exercies.name)
            }
        }
        
    }
    
    func fetchClassesFromTK() {
        TKClassCtrl.fetchClasses(withFetchSortOptions: [.name]) { (fetchedClasses,error) in
            if error != nil {
                print("Failed fetching Classes from TK!" + error.debugDescription)
            }
            else {
                self.gameCardModel.downloadedClasses = fetchedClasses
                for myclass in fetchedClasses {
                    self.fetchSubjectsForClassFromTK(mytkclass: myclass)
                }
                print("Fetched \(fetchedClasses.count) Classes from TK sucessfully")
            }
        }
    }
    
    func fetchSubjectsForClassFromTK(mytkclass : TKClass) {
        TKSubjectCtrl.fetchSubject(forClass: mytkclass, withFetchSortOptions: [.name]) { (fetchedSubjects, error) in
            if error != nil {
                print("Failed fetching Subject from TK! class:" + mytkclass.recordTypeID! + "with Error Message: " + error.debugDescription)
            }
            else {
                self.gameCardModel.downloadedSubjects.append(fetchedSubjects)
                for mysubject in fetchedSubjects{
                    self.fetchDocumentsForSubjectFromTK(mytksubject: mysubject)
                    }
                print("Fetched \(self.gameCardModel.downloadedSubjects.count) Subjects from TK sucessfully")
            }
        }
    }
    
    func fetchDocumentsForSubjectFromTK(mytksubject : TKSubject) {
        TKDocumentCtrl.fetchDocuments(forSubject: mytksubject, withFetchSortOptions: [.name]) { (fetchedDocuments, error) in
            if error != nil {
                print("Failed fetching Documents from TK! Subjects:" + mytksubject.name + "with Error Message: " + error.debugDescription)
            }
            else {
                self.gameCardModel.downloadedDocuments.append(fetchedDocuments)
                for mydocument in fetchedDocuments{
                    self.fetchExercisesForDocumentFromTK(mytkdocument: mydocument)
                }
                print("Fetched \(self.gameCardModel.downloadedDocuments.count) Documents from TK sucessfully")
                
                DispatchQueue.main.async { // very nice DispatchQueue
                    self.updateGamesList()
                }
            }
        }
    }
    
    func fetchExercisesForDocumentFromTK(mytkdocument : TKDocument) {
        TKExerciseCtrl.fetchExercises(forDocument: mytkdocument, withFetchSortOptions: [.name]) { (fetchedExercises, error) in
            if error != nil {
                print("Failed fetching Exercises from TK! Subjects:" + mytkdocument.name + "with Error Message: " + error.debugDescription)
            }
            else {
                self.gameCardModel.downloadedExercises.append(fetchedExercises)
                print("Fetched \(self.gameCardModel.downloadedExercises.count) Exercises from TK sucessfully")
                self.debugPrintAfterFetch()
            }
        }
    }
    
    func addGame(name : String, typ : String, deadline : Date?, subject : String, tries : Int) {
        let tempGameInformation = GameInformationItem(name: name, typ: typ, deadline: deadline, subject: subject, tries: tries)
        
        gameCardModel.data.append(tempGameInformation)
        
        NotificationCenter.default.post(name: .reloadGameCards , object: nil)
    }
    
    func resetGames(){
        gameCardModel.data = []
    }
    
    func getGamesCount() -> Int {
        return gameCardModel.data.count
    }
    
    func getGame(forIndex : Int) -> GameInformationItem {
        return gameCardModel.data[forIndex]
    }
    
    
}
