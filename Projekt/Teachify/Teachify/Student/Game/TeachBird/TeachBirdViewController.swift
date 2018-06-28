//
//  TeachBirdViewController.swift
//  Teachify
//
//  Created by Christian Pöhlmann on 21.06.18.
//  Copyright © 2018 Christian Pfeiffer. All rights reserved.
//

import UIKit
import SpriteKit
import GameplayKit

class TeachBirdViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let scene = GameScene(size: view.bounds.size)
        //let sensor = Sensoring(game: scene as! NSObject)
        
//        let skView = view as! SKView
        let skView: SKView = {
            let view = SKView()
            view.translatesAutoresizingMaskIntoConstraints = false
            return view
        }()
        skView.showsFPS = true
        skView.showsNodeCount = true
        skView.ignoresSiblingOrder = false
        scene.scaleMode = .resizeFill
        skView.presentScene(scene)
    }
    override var shouldAutorotate: Bool {
        return false
    }
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        if UIDevice.current.userInterfaceIdiom == .phone {
            return .allButUpsideDown
        } else {
            return .all
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Release any cached data, images, etc that aren't in use.
    }
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
}
