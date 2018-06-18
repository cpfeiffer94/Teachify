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
    
    func getMySubjects(){
        model.mySubjects = tkFetchCtrl.getSubjects()
    }
    
    func isMySubjectSet() -> Bool {
        if model.mySubjects != nil{
            return true
        }
        else {
            return false
        }
    }
    
    func getMySubjects() -> [TKSubject] {
        return model.mySubjects!
    }
    
    func getMySubjectsCount() -> Int {
        return (model.mySubjects?.count)!
    }
    
//############################################
//MARK: Methods for continous Mode
    
    private func setContinousGameList() {
        model.continousGames = []
        
//        Follow The Order
        model.continousGames.append(ContinousGameInformationItem(name: "Word Translation", type: .wordTranslation, subject: "Englisch", color: .blue, image: UIImage(named: "calculator")!))
//        Feed Me
        model.continousGames.append(ContinousGameInformationItem(name: "Feed Me", type: .feedme, subject: "Mathe", color: .yellow, image: UIImage(named: "calculator")!))
//        Math Piano
        model.continousGames.append(ContinousGameInformationItem(name: "Math Piano", type: .mathpiano, subject: "Math", color: .red, image: UIImage(named: "calculator")!))
        
        NotificationCenter.default.post(name: .reloadGameCards , object: nil)
        
    }
    
    func getContinousGame(index : Int) -> ContinousGameInformationItem {
        return model.continousGames[index]
    }
    
    func getContinousGameCount() -> Int {
        return model.continousGames.count
    }
    
    
}
