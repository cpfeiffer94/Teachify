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
    
    //### SKNodes ###
    var playButton: BasicButton!
    var returnButton: BasicButton!
    var highscoreLabel: SKLabelNode!
    var rankingLabel: SKLabelNode!
    
    //### Constant ###
    let playButtonText = "Play again"
    let returnButtonText = "Return"
    
    var feedback: MathPianoGameFeedbackModel!
    var isEndless: Bool!
    var highscore: Int?
    var score: SKLabelNode!
    
    
    
    override func didMove(to view: SKView) {
        
        setupBackground()
        if feedback == nil{
            removeVC()
        }
        
        if feedback == nil{
            removeVC()
        }
        
        if !isEndless{
            setupRanking()
        }
    
        
        for item in feedback!.userAnswer{
            print(item)
        }
        
        playButton = BasicButton(texture: nil, color: UIColor.green, size: CGSize(width: 250, height: 75),fontColor: UIColor.black, text: playButtonText)
        playButton.delegate = self
        playButton.isUserInteractionEnabled = true
        playButton.position = CGPoint(x: self.frame.width / 2, y: self.frame.height / 1.5)
        
        returnButton = BasicButton(texture: nil, color: UIColor.red, size: CGSize(width: 250, height: 75), fontColor: UIColor.black, text: returnButtonText)
        returnButton.delegate = self
        returnButton.isUserInteractionEnabled = true
        returnButton.position = CGPoint(x: self.frame.width / 2, y: self.frame.height / 1.5 - 75 - playButton.size.height)
        
        if highscore != nil{
            setupScore()
            addChild(playButton)
            
        }
        addChild(returnButton)
    }
    
    @inline(__always)
    fileprivate func setupBackground(){
        let backgroundNode = SKSpriteNode(imageNamed: "background.pngs")
        backgroundNode.position = CGPoint(x: size.width/2, y: size.height/2)
        backgroundNode.size = self.size
        addChild(backgroundNode)
    }
    
    @inline(__always)
    fileprivate func setupScore() {
        score = SKLabelNode(text:"Highscore: \(String(highscore!))")
        score.position = CGPoint(x: self.frame.width / 2,y: self.frame.height / 1.3)
        score.fontName = "AvenirNext-Bold"
        score.fontSize = 45
        score.fontColor = UIColor.black
        addChild(score)
    }
    @inline(__always)
    fileprivate func setupRanking(){
        let rank = calculateRank()
        rankingLabel = SKLabelNode(text: rank)
        rankingLabel.position = CGPoint(x: self.frame.width / 2,y: self.frame.height / 1.3)
        rankingLabel.fontName = "AvenirNext-Bold"
        rankingLabel.fontSize = 45
        rankingLabel.fontColor = UIColor.black
        addChild(rankingLabel)
    }
    
    fileprivate func calculateRank() -> String{
        var count = 1
        for i in 0..<feedback!.pianoModel.gameQuestions.count - 1{
            if feedback!.userAnswer[i] == String(feedback!.pianoModel.gameQuestions[i].correctAnswer!){
                count = count + 1
            }
        }
        return "\(count)/\(feedback!.pianoModel!.gameQuestions.count) richtige Antworten"
    }
    
    
    fileprivate func removeVC(){
        let nc = NotificationCenter.default
        nc.post(name: NSNotification.Name("exitGame"), object: nil)
    }
    
    func basicButtonPressed(_ button: BasicButton) {
        switch button.label.text! {
        case playButtonText:
            let basic = BasicScene(size: self.size)
            self.scene!.view!.presentScene(basic)
            break
        case returnButtonText:
            removeVC()
            break
        default:
            return
        }
    }
    
   
    
    
    
}
