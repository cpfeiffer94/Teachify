
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
    let buttonImageName = "umbrella.png"
    var lastUpdateTime: TimeInterval!
    let buttonSize = 150
    var question: [String] = []
    var correctAnswer: [Int] = []
    var labels: [BasicNode] = []
    var answers: [[Int]] = []
    var maxNumberOfWaves = 1
    var score: Int!{
        didSet{
            if scoreLabel != nil{
                //update the score label
                animateScoreLabel()
                scoreLabel.text = String(score)
            }
        }
    }
    enum Mode{
        case endless
        case task
    }
    var gameMode: Mode!
    var scoreLabel: SKLabelNode!
    
   
    
    override func didMove(to view: SKView) {
        
        //### setup ###
        let backgroundNode = SKSpriteNode(imageNamed: "background.pngs")
        backgroundNode.position = CGPoint(x: size.width/2, y: size.height/2)
        backgroundNode.size = self.size
        addChild(backgroundNode)
        
        let memoryGames = RandomQuestionGenerator().generateGame(numberOfQuestions: 10, lifes: 9)
        gameMode = Mode.task
        
        
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
        
        if gameMode == Mode.endless{
            setupScore()
            maxNumberOfWaves = question.count - 1
        }
        
        generateQuestion()
        generateButtons(answers: answers[0])
        
        //timer setup
        timer1 = Timer.scheduledTimer(timeInterval: 2.0, target: self, selector: #selector(self.generateQuestion), userInfo: nil, repeats: true)
    }
    
    fileprivate func setupScore() {
        score = 3
        scoreLabel = SKLabelNode(text: String(score))
        scoreLabel.zPosition = 1
        scoreLabel.position = CGPoint(x: self.frame.width - 100, y: self.frame.height - 100)
        scoreLabel.fontSize = 60
        scoreLabel.fontName = "AvenirNext-Bold"
        addChild(scoreLabel)
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
    
    @objc func moveLabel(deltaTime: TimeInterval){
        
        for item in labels{
            if item.position.y < 475{
                item.removeFromParent()
                print("label.y=\(item.position.y)")
                wrongAnswer()
            }
            else{
                let moveDown = SKAction.moveBy(x: 0, y:-120 * CGFloat(deltaTime), duration: 0)
                item.run(moveDown)
            }
        }
    }
    
    
    func rightAnswer(){
        
        if(labels.count > 0){
            var action: SKAction
            action = SKAction.fadeOut(withDuration: 1)
            let destroyedLabel = labels.first
            labels.first?.run(action){
                destroyedLabel?.removeFromParent()
            }
        }
        if question.count <= 0{
            win()
        }
        else{
            nextQuestion()
            if answers.count > 0{
                generateButtons(answers: answers[0])
            }
        }
        
    }
    
    func wrongAnswer(){
        if gameMode == Mode.endless{
            score = score - 1
            if score <= 0{
                lose()
            }
            else{
                generateButtons(answers: answers[0])
            }
        }
        else{
            let action = SKAction.fadeOut(withDuration: 1)
            labels.first?.run(action)
            nextQuestion()
            if answers.count > 0{
                generateButtons(answers: answers[0])
            }
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
    
    fileprivate func nextQuestion(){
        labels.removeFirst()
        question.removeFirst()
        answers.removeFirst()
        correctAnswer.removeFirst()
    }
    
    @objc func generateQuestion(){
            if labels.count < maxNumberOfWaves{
                if question.count >= 1{
                    if labels.count < question.count{
                        let label = BasicNode.init(texture: nil, color: UIColor.white, size: CGSize(width: self.frame.width, height: self.frame.height + 600), text: question[labels.count], fontColor: UIColor.black, image: "wave.png")
                        label.position = CGPoint(x: self.frame.width / 2, y: self.frame.height * CGFloat(1.6))
                        label.label.position.y = label.label.position.y - 450
                        print("generateQuestion: \(label.position.y)")
                        label.label.fontSize = 40
                        label.label.fontName = "AvenirNext-Bold"
                        label.alpha = 0.1
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
        
        //TODO: implement the copy(from:) int basicButton
        if question.count == 0{
            win()
        }
        
        if gameBtn != nil{
            gameBtn.removeFromParent()
        }
        //### 1 ###
        gameBtn = BasicButton(texture: nil, color: UIColor.red, size: CGSize(width: 200, height: 75),text: String(answers[0]), fontColor: UIColor.white,image: buttonImageName)
        gameBtn.position = CGPoint(x: self.frame.width / 2, y: self.frame.height / 15)
        gameBtn.isUserInteractionEnabled = true
        gameBtn.delegate = self
        gameBtn.zPosition = 10
        
        if gameBtn1 != nil{
            gameBtn1.removeFromParent()
        }
        //### 2 ###
        gameBtn1 = BasicButton(texture: nil, color: UIColor.red, size: CGSize(width: 200, height: 75),text: String(answers[1]), fontColor: UIColor.white, image: buttonImageName)
        gameBtn1.position = CGPoint(x: self.frame.width / 2 + 250, y: self.frame.height / 15)
        gameBtn1.isUserInteractionEnabled = true
        gameBtn1.delegate = self
        gameBtn1.zPosition = 10
        
        if gameBtn2 != nil{
            gameBtn2.removeFromParent()
        }
        //### 3 ###
        gameBtn2 = BasicButton(texture: nil, color: UIColor.red, size: CGSize(width: 200, height: 75),text: String(answers[2]), fontColor: UIColor.white,image: buttonImageName)
        gameBtn2.position = CGPoint(x: self.frame.width / 2 - 250, y: self.frame.height / 15)
        gameBtn2.isUserInteractionEnabled = true
        gameBtn2.delegate = self
        gameBtn2.zPosition = 10
        
        addChild(gameBtn)
        addChild(gameBtn1)
        addChild(gameBtn2)
        
    }
    func some(){
        
    }
    
    func win(){
        timer1.invalidate()
        let nc = NotificationCenter.default
        nc.post(name: NSNotification.Name("exitGame"), object: nil)
    }
    
    func lose(){
        timer1.invalidate()
        let result = ResultScene(size: self.size)
        let transition = SKTransition.flipVertical(withDuration: 1.0)
        result.winner = false
        self.scene!.view?.presentScene(result, transition: transition)
    }
    
    
    override func update(_ currentTime: TimeInterval) {
            labels.first?.alpha = 1
            if lastUpdateTime == nil{
                lastUpdateTime = currentTime
            }
            let deltaTime = currentTime - lastUpdateTime
            lastUpdateTime = currentTime
            print("deltaTime: \(deltaTime)")
            moveLabel(deltaTime: deltaTime)
    }
    
    
    func BG(_ block: @escaping ()->Void) {
        DispatchQueue.global(qos: .default).async(execute: block)
    }
}
