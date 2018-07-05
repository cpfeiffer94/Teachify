//
//  GameViewController.swift
//  Teachify
//
//  Created by Normen Krug on 08.04.18.
//  Copyright © 2018 Christian Pfeiffer. All rights reserved.
//

import UIKit
import SpriteKit

class MathPianoGameViewController: UIViewController {
    
    var converterReturn: (MathPianoGame, Bool)!
    var mathPianoGameModel: MathPianoGame!
    
    let skView: SKView = {
        let view = SKView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    var scene: BasicScene!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("Game")
        
        scene = BasicScene(size: view.frame.size)
        let converter = ExerciseConverter()
        converterReturn = converter.convert()
        
        if converterReturn.1{
             mathPianoGameModel = RandomQuestionGenerator().generateGame(numberOfQuestions: 10, lifes: 3)
             scene.gameMode = .endless

        }else{
            mathPianoGameModel = converterReturn.0
            scene.gameMode = .task
        }
        //
        
        
      
        
        NotificationCenter.default.addObserver(self, selector: #selector(exitGame), name: Notification.Name("exitGame"), object: nil)
    
        // Do any additional setup after loading the view.
        view.addSubview(skView)
        skView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        skView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        skView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        skView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        scene.pianoModel = mathPianoGameModel
        skView.presentScene(scene)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @objc func exitGame(){
        //TODO: let viewcontroller disappear 
        
        self.dismiss(animated: true) {
            self.scene.removeFromParent()
        }
        //switch to view 
    }
    
}
