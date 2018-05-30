//
//  StudentModelSingelton.swift
//  Teachify
//
//  Created by Christian Pfeiffer on 30.05.18.
//  Copyright © 2018 Christian Pfeiffer. All rights reserved.
//

import Foundation

class StudentModelSingleton {
    //TODO Zugriffsschicht
    static let sharedInstance = StudentModelSingleton()
    fileprivate var data : [GameCardInformationItem] = []
    fileprivate var myClass : TKClass?
    
    private init (){}
}


class StudentModelController : NSObject {
    fileprivate var model = StudentModelSingleton.sharedInstance
    fileprivate var tkModelController = TKFetchController(rank: .teacher)
    
    override init(){}
    
    func setMyClass(myClassName : String){
        let modelIndex = tkModelController.getClassIndexForName(queryName: myClassName)
        
        if (modelIndex > -1){
            model.myClass = tkModelController.getClassForIndex(myIndex: modelIndex)
        }
        
        else {
            print("Unable to fetch Students Class from tkModelController!")
        }
    }
    
    func isMyClassSet() -> Bool {
        if model.myClass != nil{
            return true
        }
        else {
            return false
        }
    }
    
    func getMyClass() ->TKClass {
        return model.myClass!
    }
    
    
    
    //    Convert TKDocuments to GameCardModel Items
    private func updateGamesList(with documents: [TKDocument]) {
        model.data = []
        for document in documents {
            addExercise(name: document.name, deadline: document.deadline, subject: document.subjectID!, tries: 3)
        }
        
    }
    
    ///    adding a GameInformationItem to the gameCardModel for the StudentMainMenuCardView notifying the VC to reload the Collectionitems.
    func addExercise(name : String, deadline : Date?, subject : String, tries : Int) {
        let tempGameInformation = GameCardInformationItem(name: name, deadline: deadline, subject: subject, tries: tries)
        
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
    
    func getGame(forIndex : Int) -> GameCardInformationItem {
        return model.data[forIndex]
    }
    
    
}
