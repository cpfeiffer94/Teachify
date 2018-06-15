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
    fileprivate var myClass : TKClass?
    
    private init (){}
}


class StudentModelController : NSObject {
    fileprivate var model = StudentModelSingleton.sharedInstance
    fileprivate var tkModelController = TKFetchController()
    
    override init(){
        super.init()
        self.setContinousGameList()
    }
    
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
