//
//  GameCollectionDataSource.swift
//  Teachify
//
//  Created by Christian Pfeiffer on 12.04.18.
//  Copyright © 2018 Christian Pfeiffer. All rights reserved.
//

import UIKit

class GameCollectionDataSource: NSObject,UICollectionViewDataSource {
    let studentController : StudentModelController = StudentModelController()

    override init(){

    }
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        if studentController.isMyClassSet() {
            return studentController.getMyClass().subjects.count
        }
        else {
            return 0
        }
            
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if studentController.isMyClassSet() {
            return studentController.getMyClass().subjects[section].documents.count
        }
        else {
            return 0
        }
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CardCell", for: indexPath) as! GameCardCell
        var tlc = collectionView.window?.rootViewController as! UIViewController
        tlc = UIWindow.getVisibleViewControllerFrom(vc: tlc)
        
        if studentController.isMyClassSet() {
        let tempclass = studentController.getMyClass()
        cell.card.backgroundColor = tempclass.subjects[indexPath.item].color.color
        cell.card.icon = UIImage(named: "calculator")
        cell.card.title = tempclass.subjects[indexPath.item].documents[indexPath.row].name
        cell.card.itemTitle = tempclass.subjects[indexPath.item].name
        cell.card.itemSubtitle = "Anzahl Übungen: \(tempclass.subjects[indexPath.item].documents[indexPath.row].exercises.count)"
        cell.card.buttonText = "Spielen"
        cell.card.textColor = UIColor.white

        cell.card.hasParallax = true
        cell.card.action

        let cardContentVC = tlc.storyboard!.instantiateViewController(withIdentifier: "CardContent")
        cell.card.shouldPresent(cardContentVC, from: tlc, fullscreen: false)

            cell.view.addSubview(cell.card)
            
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        if let sectionHeader = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "GameCardCellHeader", for: indexPath) as? SectionHeader{
            
            if studentController.isMyClassSet() {
                sectionHeader.SectionTitleLabel.text = studentController.getMyClass().subjects[indexPath.item].name
            }
        }
        return UICollectionReusableView()
    }
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
