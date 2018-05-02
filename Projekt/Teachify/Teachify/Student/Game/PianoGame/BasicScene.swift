
//  BasicScene.swift
//  Teachify
//
//  Created by Normen Krug on 11.04.18.
//  Copyright © 2018 Christian Pfeiffer. All rights reserved.
//
import Foundation
import SpriteKit


class BasicScene: SKScene, BasicButtonDelegate{
  
    var timer : Timer!
    var timer1: Timer!
    
    var gameBtn: BasicButton!
    var gameBtn1: BasicButton!
    var gameBtn2: BasicButton!
    
    let buttonSize = 150
    var question: [String] = []
    var correctAnswer: [Int] = []
    var labels: [SKLabelNode] = []
    var answers: [[Int]] = []
    var score: Int!{
        didSet{
            if scoreLabel != nil{
                //update the score label
                animateScoreLabel()
                scoreLabel.text = String(score)
            }
        }
    }
    var scoreLabel: SKLabelNode!
    
    override func didMove(to view: SKView) {
        //setup
        let memoryGames = RandomQuestionGenerator().generateGame(numberOfQuestions: 10, lifes: 9)
        
        // translate games
        for gameItem in memoryGames.gameQuestions {
            question.append(gameItem.getQuestionAsString())
            correctAnswer.append(gameItem.correctAnswer!) // forced
            
            var questionsOfAGame : [Int] = []
            
            for answer in gameItem.allAnswers! { // forced
                questionsOfAGame.append(answer)
            }
            answers.append(questionsOfAGame)
        }
        
        
        score = 3
        scoreLabel = SKLabelNode(text: String(score))
        scoreLabel.position = CGPoint(x: self.frame.width - 100, y: self.frame.height - 100)
        scoreLabel.fontSize = 60
        scoreLabel.fontName = "AvenirNext-Bold"
        addChild(scoreLabel)
        
        
        
        //timer
        generateQuestion()
        generateButtons(answers: answers[0])
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(self.moveLabel), userInfo: nil, repeats: true)
        timer1 = Timer.scheduledTimer(timeInterval: 2.0, target: self, selector: #selector(self.generateQuestion), userInfo: nil, repeats: true)
    }
    
    func animateScoreLabel(){
        var group1 = Array<SKAction>()
        let srinkSize = SKAction.scale(to: 0.6, duration: 1.0)
        let changeColor = SKAction.colorize(with: UIColor.red, colorBlendFactor: CGFloat(100), duration: 1.0)
        group1.append(changeColor)
        group1.append(srinkSize)
        let actions = SKAction.group(group1)
        scoreLabel.run(actions){
            var group2 = Array<SKAction>()
            let strechSize = SKAction.scale(to: 1.0, duration: 1.0)
            let changeColorBack = SKAction.colorize(with: UIColor.white, colorBlendFactor: CGFloat(100), duration: 1.0)
            
            group2.append(strechSize)
            group2.append(changeColorBack)
            let actions1 = SKAction.group(group2)
            
            self.scoreLabel.run(actions1)
        }
    }
    
    @objc func moveLabel(){
        
        for item in labels{
            if item.position.y < 150{
                labels.removeFirst()
                question.removeFirst()
                item.removeFromParent()
                wrongAnswer()
            }
            else{
                let moveDown = SKAction.moveBy(x: 0, y:-150, duration: 1.0)
                item.run(moveDown)
            }
        }
    }
    
    func rightAnswer(){
        
        if(labels.count > 0){
            let number = CGFloat(Float(arc4random()) / Float(UINT32_MAX))
            var action: SKAction
            if number > 0.5{
                action = SKAction.move(to: CGPoint(x: (labels.first?.position.x)! - self.frame.width,y: (labels.first?.position.y)!), duration: 1.0)
            }else{
                action = SKAction.move(to: CGPoint(x: (labels.first?.position.x)! + self.frame.width,y: (labels.first?.position.y)!), duration: 1.0)
            }
            let destroyedLabel = labels.first
            labels.first?.run(action){
                destroyedLabel?.removeFromParent()
            }
            self.labels.removeFirst()
            self.question.removeFirst()
            self.answers.removeFirst()
            self.correctAnswer.removeFirst()
            
        }
        if question.count == 0{
            win()
        }
        else{
            generateButtons(answers: answers[0])
        }
    }
    
    func wrongAnswer(){
        
        score = score - 1
        if score <= 0{
            lose()
        }
    }
    
    func basicButtonPressed(_ button: BasicButton) {
        if button.label.text == String(correctAnswer[0]){
            rightAnswer()
        }
        else{
            wrongAnswer()
        }
    }
    
    @objc func generateQuestion(){
        if labels.count < 5{
            if question.count >= 1{
                if labels.count < question.count{
                    let label = SKLabelNode(text: question[labels.count])
                    label.position = CGPoint(x: self.frame.width / 2, y: self.frame.height)
                    label.fontSize = 40
                    label.fontName = "AvenirNext-Bold"
                    addChild(label)
                    labels.append(label)
                }
            }
        }
        if question.count == 0{
            win()
        }
    }
    
    func generateButtons(answers: [Int]){
        
       
        
        if gameBtn != nil{
            gameBtn.removeFromParent()
        }
        //### 1 ###
        gameBtn = BasicButton(texture: nil, color: UIColor.red, size: CGSize(width: 200, height: 75),text: String(answers[0]), fontColor: UIColor.white)
        gameBtn.position = CGPoint(x: self.frame.width / 2, y: self.frame.height / 15)
        gameBtn.isUserInteractionEnabled = true
        gameBtn.delegate = self
        
        if gameBtn1 != nil{
            gameBtn1.removeFromParent()
        }
        //### 2 ###
        gameBtn1 = BasicButton(texture: nil, color: UIColor.red, size: CGSize(width: 200, height: 75),text: String(answers[1]), fontColor: UIColor.white)
        gameBtn1.position = CGPoint(x: self.frame.width / 2 + 250, y: self.frame.height / 15)
        gameBtn1.isUserInteractionEnabled = true
        gameBtn1.delegate = self
        
        if gameBtn2 != nil{
            gameBtn2.removeFromParent()
        }
        //### 3 ###
        gameBtn2 = BasicButton(texture: nil, color: UIColor.red, size: CGSize(width: 200, height: 75),text: String(answers[2]), fontColor: UIColor.white)
        gameBtn2.position = CGPoint(x: self.frame.width / 2 - 250, y: self.frame.height / 15)
        gameBtn2.isUserInteractionEnabled = true
        gameBtn2.delegate = self
        
        addChild(gameBtn)
        addChild(gameBtn1)
        addChild(gameBtn2)
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        print("touchesBegan")
    }
    
    func win(){
        timer.invalidate()
        timer1.invalidate()
        let result = ResultScene(size: self.size)
        let transition = SKTransition.flipVertical(withDuration: 1.0)
        result.winner = true
        self.scene!.view?.presentScene(result, transition: transition)
    }
    func lose(){
        timer.invalidate()
        timer1.invalidate()
        let result = ResultScene(size: self.size)
        let transition = SKTransition.flipVertical(withDuration: 1.0)
        result.winner = false
        self.scene!.view?.presentScene(result, transition: transition)
    }
    
    func BG(_ block: @escaping ()->Void) {
        DispatchQueue.global(qos: .default).async(execute: block)
    }
}
