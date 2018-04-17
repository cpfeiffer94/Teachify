//
//  GameCardModel.swift
//  Teachify
//
//  Created by Christian Pfeiffer on 12.04.18.
//  Copyright © 2018 Christian Pfeiffer. All rights reserved.
//

import UIKit

class GameCardModelSingleton {
    
    static let sharedInstance = GameCardModelSingleton()
    fileprivate var data : [GameInformationItem] = []
    
    private init (){}
}


class GameDownloadController: NSObject {
    fileprivate var model = GameCardModelSingleton.sharedInstance
    
    
    func DownloadAvailableGamesFromTK(){
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
