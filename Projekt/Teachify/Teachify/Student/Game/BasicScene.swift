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
    var question: [String]! = []
    var correctAnswer: [Int]! = []
    var labels: [SKLabelNode] = []
    var answers: [[Int]]! = []
    
    override func didMove(to view: SKView) {
        //setup
        let memoryGames = RandomQuestionGenerator().generateGame(numberOfQuestions: 10, lifes: 9)

        
        for gameItem in memoryGames.gameQuestions {
            question.append(gameItem.getQuestionAsString())
            correctAnswer.append(gameItem.correctAnswer!) // forced
            
            var questionsOfAGame : [Int] = []
            
            for answer in gameItem.allAnswers! { // forced
                questionsOfAGame.append(answer)
            }
            answers.append(questionsOfAGame)
            
        }
        
        //timer
        generateQuestion()
        generateButtons(answers: answers[0])
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(self.moveLabel), userInfo: nil, repeats: true)
        timer1 = Timer.scheduledTimer(timeInterval: 4.0, target: self, selector: #selector(self.generateQuestion), userInfo: nil, repeats: true)
    }
    
    @objc func moveLabel(){
        
        for item in labels{
            if item.position.y < 150{
                labels.removeFirst()
                print("remove first")
                item.removeFromParent()
            }
            else{
                let moveDown = SKAction.moveBy(x: 0, y:-70, duration: 0.95)
                item.run(moveDown)
            }
        }
    }
    
    func buttonCallback1() -> Void {
        
        if gameBtn.label.text == String(correctAnswer[0]){
            rightAnswer()
        }
        else{
        }
    }
    func buttonCallback2() -> Void{
        if gameBtn1.label.text == String(correctAnswer[0]){
            rightAnswer()
        }
        else{
    }
        
    }
    func buttonCallback3() -> Void{
        if gameBtn2.label.text == String(correctAnswer[0]){
            rightAnswer()
        }
        else{
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
    
    @objc func generateQuestion(){
        if labels.count < 3{
            if question.count > 1{
                let label = SKLabelNode(text: question[0 + labels.count])
                label.position = CGPoint(x: self.frame.width / 2, y: self.frame.height)
                addChild(label)
                labels.append(label)
            }
        }
        if question.count == 0{
            timer.invalidate()
        }
    }
    
    func generateButtons(answers: [Int]){
        
        //### 1 ###
        gameBtn = BasicButton(texture: nil, color: UIColor.red, size: CGSize(width: 150, height: 50), action: buttonCallback1,text: String(answers[0]))
        gameBtn.position = CGPoint(x: self.frame.width / 2, y: self.frame.height / 15)
        gameBtn.isUserInteractionEnabled = true
        
        //### 2 ###
        gameBtn1 = BasicButton(texture: nil, color: UIColor.red, size: CGSize(width: 150, height: 50), action: buttonCallback2,text: String(answers[1]))
        gameBtn1.position = CGPoint(x: self.frame.width / 2 + 200, y: self.frame.height / 15)
        gameBtn1.isUserInteractionEnabled = true
        
        //### 3 ###
        gameBtn2 = BasicButton(texture: nil, color: UIColor.red, size: CGSize(width: 150, height: 50), action: buttonCallback3,text: String(answers[2]))
        gameBtn2.position = CGPoint(x: self.frame.width / 2 - 200, y: self.frame.height / 15)
        gameBtn2.isUserInteractionEnabled = true
        
        addChild(gameBtn)
        addChild(gameBtn1)
        addChild(gameBtn2)
        
    }
    func win(){
        print("Winner Winner Chicken Dinner")
        timer.invalidate()
        timer1.invalidate()
    }
    func lose(){
        print("Nice try")
        timer.invalidate()
        timer1.invalidate()
    }
}
