
//  BasicScene.swift
//  Teachify
//
//  Created by Normen Krug on 11.04.18.
//  Copyright © 2018 Christian Pfeiffer. All rights reserved.
//
import Foundation
import SpriteKit


class BasicScene: SKScene, BasicButtonDelegate{
    
    //### Models ###
    var pianoModel: MathPianoGame?
    var questionModel: [MathPianoQuestionModel]?
    var currentQuestion: MathPianoQuestionModel!
    
    //### SKNodes ###
    var gameBtn: BasicButton!
    var gameBtn1: BasicButton!
    var gameBtn2: BasicButton!
    
    //### game specific variables ###
    var highscore: Int!
    let buttonImageName = "umbrella.png"
    var lastUpdateTime: TimeInterval!
    let buttonSize = 150
    var tempOfLabels = -120
    var labelsArray: [BasicNode] = []
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
        
        
        setupBackground()
        
        //debug
        gameMode = Mode.endless
        
        if gameMode == Mode.endless{
            
            pianoModel = RandomQuestionGenerator().generateGame(numberOfQuestions: 10, lifes: 3)
            setupScore()
        }else{
            if let questions = pianoModel?.gameQuestions{
                questionModel = questions
                currentQuestion = questions.first
            }
            else{
                let nc = NotificationCenter.default
                nc.post(name: NSNotification.Name("exitGame"), object: nil)
                return
            }
        }
        
        generateQuestion()
        generateButtons()
    }
    
    override func update(_ currentTime: TimeInterval) {
        labelsArray.first?.alpha = 1
        if lastUpdateTime == nil{
            lastUpdateTime = currentTime
        }
        let deltaTime = currentTime - lastUpdateTime
        lastUpdateTime = currentTime
        moveLabel(deltaTime: deltaTime)
        generateQuestion()
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
        
        for item in labelsArray{
            if item.position.y < 475{
                item.removeFromParent()
                wrongAnswer()
            }
            else{
                let moveDown = SKAction.moveBy(x: 0, y: CGFloat(tempOfLabels) * CGFloat(deltaTime), duration: 0)
                item.run(moveDown)
            }
        }
    }
    
    
    func rightAnswer(){
        
        highscore = highscore + 1

        labelsArray.first!.label.fontColor = UIColor.green
        labelsArray.first!.label.text = addedAnswerToQuestion()
        
        if(labelsArray.count > 0){
            animateWeaves()
            prepareNextQuestion()
        }
        if pianoModel!.currentQuestionPointer == pianoModel!.gameQuestions.count{
                if gameMode == Mode.task{
                    win()
                }
                else{
                    generateButtons()
                }
        }
        else{
            generateButtons()
        }
        if gameMode == Mode.endless{
            tempOfLabels = tempOfLabels - 5
        }
        
    }
    
    
    
    func wrongAnswer(){
        labelsArray.first?.label.fontColor = UIColor.red
        labelsArray.first?.label.text = addedAnswerToQuestion()
        animateWeaves()
        if gameMode == Mode.endless{
            score = score - 1
            if score <= 0{
                lose()
            }
        }
        prepareNextQuestion()
        if pianoModel!.currentQuestionPointer != pianoModel!.gameQuestions.count - 1{
            generateButtons()
        }
        else{
            win()
        }
        
       
    }
    
    func basicButtonPressed(_ button: BasicButton) {
        if button.label.text == String(pianoModel!.gameQuestions[pianoModel!.currentQuestionPointer].correctAnswer!){
            rightAnswer()
        }
        else{
            wrongAnswer()
        }
    }
    
    @objc func generateQuestion(){
        if labelsArray.count == 0{
                if !checkForNewQuestions(){
                    createQuestion(text: pianoModel!.gameQuestions[pianoModel!.currentQuestionPointer].getQuestionAsString())
                }
                else{
                    pianoModel = RandomQuestionGenerator().generateGame(numberOfQuestions: 10, lifes: 3)
                    createQuestion(text: pianoModel!.gameQuestions[pianoModel!.currentQuestionPointer].getQuestionAsString())
                }
        }
        
    }
    
    func generateButtons(){
        
        if checkForNewQuestions(){
            pianoModel = RandomQuestionGenerator().generateGame(numberOfQuestions: 10, lifes: 3)
        }
        var answers = pianoModel!.gameQuestions[pianoModel!.currentQuestionPointer].allAnswers!
        //TODO: implement the copy(from:) int basicButton
        if gameBtn != nil{
            gameBtn.removeFromParent()
            gameBtn1.removeFromParent()
            gameBtn2.removeFromParent()

        }
        
        //### 1 ###
        gameBtn = BasicButton(texture: nil, color: UIColor.red, size: CGSize(width: 200, height: 75),text: String(answers[0]), fontColor: UIColor.white,imageName: buttonImageName)
        gameBtn.position = CGPoint(x: self.frame.width / 2, y: self.frame.height / 15)
        gameBtn.isUserInteractionEnabled = true
        gameBtn.delegate = self
        gameBtn.zPosition = 10

        
        //### 2 ###
        gameBtn1 = BasicButton(texture: nil, color: UIColor.red, size: CGSize(width: 200, height: 75),text: String(answers[1]), fontColor: UIColor.white, imageName: buttonImageName)
        gameBtn1.position = CGPoint(x: self.frame.width / 2 + 250, y: self.frame.height / 15)
        gameBtn1.isUserInteractionEnabled = true
        gameBtn1.delegate = self
        gameBtn1.zPosition = 10
        
    
        //### 3 ###
        gameBtn2 = BasicButton(texture: nil, color: UIColor.red, size: CGSize(width: 200, height: 75),text: String(answers[2]), fontColor: UIColor.white,imageName: buttonImageName)
        gameBtn2.position = CGPoint(x: self.frame.width / 2 - 250, y: self.frame.height / 15)
        gameBtn2.isUserInteractionEnabled = true
        gameBtn2.delegate = self
        gameBtn2.zPosition = 10
        
        addChild(gameBtn)
        addChild(gameBtn1)
        addChild(gameBtn2)
        
    }
  
    func win(){
        let nc = NotificationCenter.default
        nc.post(name: NSNotification.Name("exitGame"), object: nil)
    }
    
    func lose(){
        let result = ResultScene(size: self.size)
        //let transition = SKTransition.flipVertical(withDuration: 1.0)
        result.winner = false
        result.highscore = highscore
        scene?.view?.presentScene(result)
    }
    
    //### Fileprivate Helper Methode ###
    
    fileprivate func prepareNextQuestion(){
        labelsArray.removeFirst()
        pianoModel!.currentQuestionPointer = pianoModel!.currentQuestionPointer + 1
    }
    
    fileprivate func createQuestion(text: String) {
        let label = BasicNode.init(texture: nil, color: UIColor.white, size: CGSize(width: self.frame.width, height: self.frame.height + 600), text: text, fontColor: UIColor.black, imageName: "wave.png")
        label.position = CGPoint(x: self.frame.width / 2, y: self.frame.height * CGFloat(1.6))
        label.label.position.y = label.label.position.y - 450
        label.label.fontSize = 40
        label.label.fontName = "AvenirNext-Bold"
        label.alpha = 0.1
        addChild(label)
        labelsArray.append(label)
    }
    
    func addedAnswerToQuestion() -> String{
        var text = String(pianoModel!.gameQuestions[pianoModel!.currentQuestionPointer].getQuestionAsString().dropLast(2))
        text.append(String(pianoModel!.gameQuestions[pianoModel!.currentQuestionPointer].correctAnswer!))
        return text
    }
    
    fileprivate func BG(_ block: @escaping ()->Void) {
        DispatchQueue.global(qos: .default).async(execute: block)
    }
    
    fileprivate func setupBackground() {
        //### setup ###
        let backgroundNode = SKSpriteNode(imageNamed: "background.pngs")
        backgroundNode.position = CGPoint(x: size.width/2, y: size.height/2)
        backgroundNode.size = self.size
        addChild(backgroundNode)
    }
    fileprivate func checkForNewQuestions() -> Bool{
        return pianoModel!.currentQuestionPointer == pianoModel!.gameQuestions.count
    }
    
    fileprivate func setupScore() {
        highscore = 0
        score = 3
        scoreLabel = SKLabelNode(text: String(score))
        scoreLabel.zPosition = 1
        scoreLabel.position = CGPoint(x: self.frame.width - 100, y: self.frame.height - 100)
        scoreLabel.fontSize = 60
        scoreLabel.fontName = "AvenirNext-Bold"
        addChild(scoreLabel)
    }
    fileprivate func animateWeaves(){
        
        let destroyedLabel = labelsArray.first

        var group1 = Array<SKAction>()
        let actionFadeOut = SKAction.fadeOut(withDuration: 1)
        let actionMoveBack = SKAction.moveBy(x: 0, y: CGFloat(200), duration: 1)

        group1.append(actionFadeOut)
        group1.append(actionMoveBack)
        
        let action = SKAction.group(group1)
        labelsArray.first?.run(action){
            destroyedLabel?.removeFromParent()
        }
    }
}

