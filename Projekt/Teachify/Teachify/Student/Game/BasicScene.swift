//
//  BasicScene.swift
//  Teachify
//
//  Created by Normen Krug on 11.04.18.
//  Copyright © 2018 Christian Pfeiffer. All rights reserved.
//

import Foundation
import SpriteKit


class BasicScene: SKScene{
    
    var timer : Timer!
    var timer1: Timer!
    var gameBtn: BasicButton!
    var gameBtn1: BasicButton!
    var gameBtn2: BasicButton!
    let buttonSize = 150
    var question: [String]!
    var correctAnswer: [Int]!
    var labels: [SKLabelNode] = []
    var answers: [(Int,Int,Int)]!
    var score: Int!{
        didSet{
            if scoreLabel != nil{
                //update the score label
                scoreLabel.text = String(score)
            }
        }
    }
    var scoreLabel: SKLabelNode!
    
    override func didMove(to view: SKView) {
        //setup
        score = 3
        scoreLabel = SKLabelNode(text: String(score))
        scoreLabel.position = CGPoint(x: self.frame.width - 100, y: self.frame.height - 100)
        scoreLabel.fontSize = 50
        addChild(scoreLabel)
        question = ["2+2","8+2","5+1","1+1","0+1"]
        correctAnswer = [4,10,6,2,1]
        answers = [(1,4,3),(4,10,8),(5,10,6),(2,8,9),(4,1,2)]
        
        
        //timer
        generateQuestion()
        generateButtons(answers: answers[0])
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(self.moveLabel), userInfo: nil, repeats: true)
        timer1 = Timer.scheduledTimer(timeInterval: 2.0, target: self, selector: #selector(self.generateQuestion), userInfo: nil, repeats: true)
    }
    
    @objc func moveLabel(){
        
        for item in labels{
            if item.position.y < 150{
                labels.removeFirst()
                question.removeFirst()
                item.removeFromParent()
                lose()
            }
            else{
                let moveDown = SKAction.moveBy(x: 0, y:-150, duration: 0.95)
                item.run(moveDown)
            }
        }
    }
    
    func buttonCallback1() -> Void{
        
        if gameBtn.label.text == String(correctAnswer[0]){
            rightAnswer()
        }
        else{
            wrongAnswer()
        }
    }
    func buttonCallback2() -> Void{
        if gameBtn1.label.text == String(correctAnswer[0]){
            rightAnswer()
        }
        else{
            wrongAnswer()
        }
        
    }
    func buttonCallback3() -> Void{
        if gameBtn2.label.text == String(correctAnswer[0]){
            rightAnswer()
        }
        else{
            wrongAnswer()
        }
        
    }
    
    func rightAnswer(){
        if(labels.count > 0){
            labels[0].removeFromParent()
            labels.removeFirst()
            question.removeFirst()
            answers.removeFirst()
            correctAnswer.removeFirst()
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
    
    @objc func generateQuestion(){
        if labels.count < 5{
            if question.count >= 1{
                print("question.count: \(question.count)")
                print("labels.count: \(labels.count)")
                if labels.count < question.count{
                    let label = SKLabelNode(text: question[labels.count])
                    label.position = CGPoint(x: self.frame.width / 2, y: self.frame.height)
                    label.fontSize = 40
                    addChild(label)
                    labels.append(label)
                }
            }
        }
        if question.count == 0{
            win()
        }
    }
    func generateButtons(answers: (Int,Int,Int)){
        
        //### 1 ###
        gameBtn = BasicButton(texture: nil, color: UIColor.red, size: CGSize(width: 150, height: 50), action: buttonCallback1,text: String(answers.0), fontColor: UIColor.white)
        gameBtn.position = CGPoint(x: self.frame.width / 2, y: self.frame.height / 15)
        gameBtn.isUserInteractionEnabled = true
        
        //### 2 ###
        gameBtn1 = BasicButton(texture: nil, color: UIColor.red, size: CGSize(width: 150, height: 50), action: buttonCallback2,text: String(answers.1), fontColor: UIColor.white)
        gameBtn1.position = CGPoint(x: self.frame.width / 2 + 200, y: self.frame.height / 15)
        gameBtn1.isUserInteractionEnabled = true
        
        //### 3 ###
        gameBtn2 = BasicButton(texture: nil, color: UIColor.red, size: CGSize(width: 150, height: 50), action: buttonCallback3,text: String(answers.2), fontColor: UIColor.white)
        gameBtn2.position = CGPoint(x: self.frame.width / 2 - 200, y: self.frame.height / 15)
        gameBtn2.isUserInteractionEnabled = true
        
        addChild(gameBtn)
        addChild(gameBtn1)
        addChild(gameBtn2)
        
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
    
}
