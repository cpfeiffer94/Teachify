//
//  GameCollectionDataSource.swift
//  Teachify
//
//  Created by Christian Pfeiffer on 12.04.18.
//  Copyright © 2018 Christian Pfeiffer. All rights reserved.
//
//  Der Code ist gut aber er ist nicht schön!

import UIKit

class GameCollectionDataSource: NSObject,UICollectionViewDataSource {
    let studentController : StudentModelController = StudentModelController()
    let tkFetchController : TKFetchController = TKFetchController()
    
    var ContiniousMode = false

    override init(){

    }
    
    func setContinousMode(isContinous : Bool){
        ContiniousMode = isContinous
    }
    
//    func numberOfSections(in collectionView: UICollectionView) -> Int {
//        if (ContiniousMode){
//            return studentController.getContinousGameCount()
//        }
//        else {
//            return tkFetchController.getSubjects().count
//        }
//    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if (ContiniousMode){
            return studentController.getContinousGameCount()
        }
        else {
            var documentCounter = 0

            for subject in tkFetchController.getSubjects() {
                documentCounter += subject.documents.count
            }
            
            return documentCounter
        }
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CardCell", for: indexPath) as! GameCardCell
        var tlc = collectionView.window?.rootViewController as! UIViewController
        tlc = UIWindow.getVisibleViewControllerFrom(vc: tlc)
        
        if ContiniousMode {
            let myGame = studentController.getContinousGame(index: indexPath.row)
            cell.card.backgroundColor = myGame.color
            cell.card.icon = myGame.backgroundImage
            cell.card.title = myGame.name
            cell.card.itemTitle = "Endlosspiel"
            cell.card.itemSubtitle = "Subtitle?"
            cell.card.buttonText = "Spielen"
            cell.card.textColor = UIColor.white
        
            
            cell.setContiniousGame(game: myGame.type)
        }
        else{
            print("my Index item: \(indexPath.item) my Index row: \(indexPath.row)")
            //            [0] is Subject; [1] is Document
                let myTuple = tkFetchController.getSubjectAndDocumentForCollectionIndex(index: indexPath.item)

                cell.card.backgroundColor = myTuple.0.color.color
                cell.card.icon = UIImage(named: "calculator")
                cell.card.title = myTuple.1.name
                cell.card.itemTitle = myTuple.0.name
                cell.card.itemSubtitle = "Anzahl Übungen: \(myTuple.1.exercises.count)"
                cell.card.buttonText = "Spielen"
                cell.card.textColor = UIColor.white
                cell.setExercises(newExercises: myTuple.1.exercises)
            
        }
        
        
        cell.card.hasParallax = true
        cell.card.action
        
        let cardContentVC = tlc.storyboard!.instantiateViewController(withIdentifier: "CardContent")
        cell.card.shouldPresent(cardContentVC, from: tlc, fullscreen: false)
        
        cell.view.addSubview(cell.card)
        return cell
    }
    
    // TODO: SectionHeader not working
//    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
//
//        if let sectionHeader = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "GameCardCellHeader", for: indexPath) as? SectionHeader{
//
//            if (ContiniousMode){
//                sectionHeader.SectionTitleLabel.text = ""
//            }
//            else {
//                if studentController.isMyClassSet() {
//                    sectionHeader.SectionTitleLabel.text = studentController.getMyClass().subjects[indexPath.item].name
//                }
//            }
//
//        }
//        return UICollectionReusableView()
//    }
}

extension UIWindow {


    func visibleViewController() -> UIViewController? {
        if let rootViewController: UIViewController  = self.rootViewController {
            return UIWindow.getVisibleViewControllerFrom(vc: rootViewController)
            
}
        return nil
    }

    class func getVisibleViewControllerFrom(vc:UIViewController) -> UIViewController {

        if vc.isKind(of: UINavigationController.self) {

            let navigationController = vc as! UINavigationController
            return UIWindow.getVisibleViewControllerFrom(vc: navigationController.visibleViewController!)

        } else if vc.isKind(of: UITabBarController.self) {

            let tabBarController = vc as! UITabBarController
            return UIWindow.getVisibleViewControllerFrom(vc: tabBarController.selectedViewController!)

        } else {

            if let presentedViewController = vc.presentedViewController {

                return UIWindow.getVisibleViewControllerFrom(vc: presentedViewController)

            } else {

                return vc;
           }
        }
    }
}
