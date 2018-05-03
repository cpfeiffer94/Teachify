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
    let TKExerciseCtrl : TKExerciseController = TKExerciseController()
    let TKDocumentCtrl : TKDocumentController = TKDocumentController()
    let TKSubjectCtrl : TKSubjectController = TKSubjectController()
    let TKClassCtrl : TKClassController = TKClassController()
    
    
    func fetchDatabase() {
        gameCardModel.downloadedClasses = []
        gameCardModel.downloadedSubjects = []
        gameCardModel.downloadedDocuments = []
        gameCardModel.downloadedExercises = []
        
        fetchClassesFromTK()
    }
    
    func updateGamesList() {
        gameCardModel.data = []
        for mydocuments in gameCardModel.downloadedDocuments {
            for document in mydocuments {
                gameCardModel.data.append(GameInformationItem(name: document.name, typ: "Kristallmathe", deadline: document.deadline, subject: "Mathematik", tries: 3))
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
                print("Fetched Classes from TK sucessfully")
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
                print("Fetched Subjects from TK sucessfully")
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
                print("Fetched Documents from TK sucessfully")
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
                print("Fetched Exercises from TK sucessfully")
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
    
    func getGamesLength() -> Int {
        return gameCardModel.data.count
    }
    
    func getGame(forIndex : Int) -> GameInformationItem {
        return gameCardModel.data[forIndex]
    }
    
    
}
