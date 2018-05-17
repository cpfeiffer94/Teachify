//
//  GameCollectionDataSource.swift
//  Teachify
//
//  Created by Christian Pfeiffer on 12.04.18.
//  Copyright © 2018 Christian Pfeiffer. All rights reserved.
//

import UIKit

//class GameCollectionDataSource: NSObject,UICollectionViewDataSource {
//    let GameCollectionController : TKFetchController = TKFetchController()
//    
//    override init(){
//        
//    }
//    
////    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
////        return GameCollectionController.getGamesCount()
////    }
////    
////    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
////        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CardCell", for: indexPath) as! GameCardCell
////        var tlc = collectionView.window?.rootViewController as! UIViewController
////        tlc = UIWindow.getVisibleViewControllerFrom(vc: tlc)
////        
////        let game : GameInformationItem = GameCollectionController.getGame(forIndex: indexPath.item)
////        
////        
////        cell.card.backgroundColor = UIColor(red: 48/255, green: 98/255, blue: 165/255, alpha: 1)
////        cell.card.icon = UIImage(named: "calculator")
////        cell.card.title = game.name
////        cell.card.itemTitle = game.subject
////        cell.card.itemSubtitle = game.type
////        cell.card.buttonText = "Spielen"
////        cell.card.textColor = UIColor.white
////        
////        cell.card.hasParallax = true
////        cell.card.action
////        
////        let cardContentVC = tlc.storyboard!.instantiateViewController(withIdentifier: "CardContent")
////        cell.card.shouldPresent(cardContentVC, from: tlc, fullscreen: false)
////        
////        cell.view.addSubview(cell.card)
////        return cell
////    }
////}
////
////extension UIWindow {
////    
////    
////    func visibleViewController() -> UIViewController? {
////        if let rootViewController: UIViewController  = self.rootViewController {
////            return UIWindow.getVisibleViewControllerFrom(vc: rootViewController)
////        }
////        return nil
////    }
////    
////    class func getVisibleViewControllerFrom(vc:UIViewController) -> UIViewController {
////        
////        if vc.isKind(of: UINavigationController.self) {
////            
////            let navigationController = vc as! UINavigationController
////            return UIWindow.getVisibleViewControllerFrom( vc: navigationController.visibleViewController!)
////            
////        } else if vc.isKind(of: UITabBarController.self) {
////            
////            let tabBarController = vc as! UITabBarController
////            return UIWindow.getVisibleViewControllerFrom(vc: tabBarController.selectedViewController!)
////            
////        } else {
////            
////            if let presentedViewController = vc.presentedViewController {
////                
////                return UIWindow.getVisibleViewControllerFrom(vc: presentedViewController)
////                
////            } else {
////                
////                return vc;
////            }
////        }
////    }
//}
