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
    fileprivate var model = TKModelSingleton.sharedInstance
    let TKExerciseCtrl : TKExerciseController = TKExerciseController()
    let TKDocumentCtrl : TKDocumentController = TKDocumentController()
    let TKSubjectCtrl : TKSubjectController = TKSubjectController()
    let TKClassCtrl : TKClassController = TKClassController()
    
    
    func fetchDatabase() {
        model.downloadedClasses = []
        model.downloadedSubjects = []
        model.downloadedDocuments = []
        model.downloadedExercises = []
        
        fetchClassesFromTK()
    }
    
    @objc func debugPrintAfterFetch () {
        for myclass in model.downloadedClasses {
            print("Downloaded Class:" + myclass.name)
        }
        
        for mysubjects in model.downloadedSubjects {
            for subject in mysubjects{
                print("Downloaded Subject:" + subject.name)
            }
        }
        
        for mydocuments in model.downloadedDocuments {
            for document in mydocuments {
                print("Downloaded Document:" + document.name)
            }
        }
        
        for myexercises in model.downloadedExercises {
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
                self.model.downloadedClasses = fetchedClasses
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
                self.model.downloadedSubjects.append(fetchedSubjects)
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
                self.model.downloadedDocuments.append(fetchedDocuments)
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
                self.model.downloadedExercises.append(fetchedExercises)
                print("Fetched Exercises from TK sucessfully")
                self.debugPrintAfterFetch()
            }
        }
    }
    
    func addGame(name : String, typ : String, deadline : Date?, subject : String, description : String, difficulty : String) {
        let tempGameInformation = GameInformationItem(name: name, typ: typ, deadline: deadline, subject: subject, description: description, difficulty: difficulty)
        
        model.data.append(tempGameInformation)
    }
    
    func resetGames(){
        model.data = []
    }
    
    func getGamesLength() -> Int {
        return model.data.count
    }
    
    func getGame(forIndex : Int) -> GameInformationItem {
        return model.data[forIndex]
    }
    
    
}
