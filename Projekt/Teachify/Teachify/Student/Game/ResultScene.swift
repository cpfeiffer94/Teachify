//
//  ResultScene.swift
//  Teachify
//
//  Created by Normen Krug on 16.04.18.
//  Copyright © 2018 Christian Pfeiffer. All rights reserved.
//

import Foundation
import SpriteKit

class ResultScene: SKScene{
    
    var playButton: BasicButton!
    var text = "Play again"
    var winner: Bool!
    var score: SKLabelNode!
    
    override func didMove(to view: SKView) {
        playButton = BasicButton(texture: nil, color: UIColor.green, size: CGSize(width: 250, height: 75), action: playAgain,text: text, fontColor: UIColor.black)
        playButton.isUserInteractionEnabled = true
        playButton.position = CGPoint(x: self.frame.width / 2, y: self.frame.height / 2 - 100)
        if winner{
            score = SKLabelNode(text: "Winner Winner Chicken Dinner")
        }
        else{
            score = SKLabelNode(text: "Game over")

        }
        score.position = CGPoint(x: self.frame.width / 2,y: self.frame.height / 2)
        score.fontName = "AvenirNext-Bold"
        score.fontSize = 45
        addChild(score)
        addChild(playButton)
    }
    
    func playAgain() -> Void{
        let basic = BasicScene(size: self.size)
        let transition = SKTransition.flipVertical(withDuration: 1.0)
        self.scene!.view?.presentScene(basic, transition: transition)
    }
    
}
