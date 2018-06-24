//
//  StudentModelSingelton.swift
//  Teachify
//
//  Created by Christian Pfeiffer on 30.05.18.
//  Copyright © 2018 Christian Pfeiffer. All rights reserved.
//

import Foundation
import UIKit

class StudentModelSingleton {
    static let sharedInstance = StudentModelSingleton()
    fileprivate var continousGames : [ContinousGameInformationItem] = []
    fileprivate var mySubjects : [TKSubject]?
    
    private init (){}
}


class StudentModelController : NSObject {
    fileprivate var model = StudentModelSingleton.sharedInstance
    fileprivate var tkFetchCtrl = TKFetchController()
    
    override init(){
        super.init()
        self.setContinousGameList()
    }
    
    
//############################################
//MARK: Methods for continous Mode
    
    private func setContinousGameList() {
        model.continousGames = []
        
//        Math Piano
        model.continousGames.append(ContinousGameInformationItem(name: "Math Piano", type: .mathpiano, subject: "Math", color: UIColor.rgb(red: 144, green: 209, blue: 21), image: UIImage(named: "icons8-classic_music")!))
        
//        Feed Me
        model.continousGames.append(ContinousGameInformationItem(name: "Feed Me", type: .feedme, subject: "Mathe", color: UIColor.rgb(red: 6, green: 43, blue: 123), image: UIImage(named: "icons8-the_dragon_team")!))

//        TeachBird
        model.continousGames.append(ContinousGameInformationItem(name: "TeachBird", type: .teachBird, subject: "Englisch", color: UIColor.rgb(red: 123, green: 31, blue: 12), image: UIImage(named: "icons8-bird")!))
        
        NotificationCenter.default.post(name: .reloadGameCards , object: nil)
        
    }
    
    func getContinousGame(index : Int) -> ContinousGameInformationItem {
        return model.continousGames[index]
    }
    
    func getContinousGameCount() -> Int {
        return model.continousGames.count
    }
    
    
}
