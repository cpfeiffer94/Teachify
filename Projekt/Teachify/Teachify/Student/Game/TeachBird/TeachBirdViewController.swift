//
//  TeachBirdViewController.swift
//  Teachify
//
//  Created by Christian Pöhlmann on 21.06.18.
//  Copyright © 2018 Christian Pfeiffer. All rights reserved.
//

import UIKit
import SpriteKit
//import GameplayKit

class TeachBirdViewController: UIViewController {
    
    let skView: SKView = {
        let view = SKView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.addSubview(skView)

        skView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        skView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        skView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        skView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        let scene = TeachGameScene(size: view.frame.size)
        
        skView.showsFPS = true
        skView.showsNodeCount = true
        skView.ignoresSiblingOrder = false

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
