//
//  ResultScene.swift
//  Teachify
//
//  Created by Normen Krug on 16.04.18.
//  Copyright © 2018 Christian Pfeiffer. All rights reserved.
//

import Foundation
import SpriteKit

class ResultScene: SKScene, BasicButtonDelegate{
    
    var playButton: BasicButton!
    var returnButton: BasicButton!
    let playButtonText = "Play again"
    let returnButtonText = "Return"
    var winner: Bool!
    var highscore: Int?
    var highscoreLabel: SKLabelNode!
    var score: SKLabelNode!
    
    
    override func didMove(to view: SKView) {
        
        setupBackground()
        setupScore()

        
        playButton = BasicButton(texture: nil, color: UIColor.green, size: CGSize(width: 250, height: 75),fontColor: UIColor.black, text: playButtonText)
        playButton.delegate = self
        playButton.isUserInteractionEnabled = true
        playButton.position = CGPoint(x: self.frame.width / 2, y: self.frame.height / 1.5)
        
        returnButton = BasicButton(texture: nil, color: UIColor.red, size: CGSize(width: 250, height: 75), fontColor: UIColor.black, text: returnButtonText)
        returnButton.delegate = self
        returnButton.isUserInteractionEnabled = true
        returnButton.position = CGPoint(x: self.frame.width / 2, y: self.frame.height / 1.5 - 75 - playButton.size.height)
        
        addChild(returnButton)
        addChild(playButton)
    }
    
    fileprivate func setupBackground(){
        let backgroundNode = SKSpriteNode(imageNamed: "background.pngs")
        backgroundNode.position = CGPoint(x: size.width/2, y: size.height/2)
        backgroundNode.size = self.size
        addChild(backgroundNode)
    }
    
    fileprivate func setupScore() {
        score = SKLabelNode(text:"Highscore: \(String(highscore!))")
        score.position = CGPoint(x: self.frame.width / 2,y: self.frame.height / 1.3)
        score.fontName = "AvenirNext-Bold"
        score.fontSize = 45
        score.fontColor = UIColor.black
        addChild(score)
    }
    
    func basicButtonPressed(_ button: BasicButton) {
        switch button.label.text! {
        case playButtonText:
            let basic = BasicScene(size: self.size)
            self.scene!.view!.presentScene(basic)
            break
        case returnButtonText:
            let nc = NotificationCenter.default
            nc.post(name: NSNotification.Name("exitGame"), object: nil)
            break
        default:
            return
        }
    }
    
    
    
}
