//
//  GameScene.swift
//  FeedMe
//
//  Created by Angelina Scheler on 25.04.18.
//  Copyright © 2018 Angelina Scheler. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    
    //    private var label : SKLabelNode?
    
    var board1 : SKSpriteNode?
    var board2 : SKSpriteNode?
    var board3 : SKSpriteNode?
    var board4 : SKSpriteNode?
    var question : SKSpriteNode?
    var dragon : SKSpriteNode?
    var frage: SKLabelNode?
    var antwort: SKLabelNode?
    var antwort2: SKLabelNode?
    var antwort3: SKLabelNode?
    var antwort4: SKLabelNode?
    var originalPosition: CGPoint?
    var heart : SKSpriteNode?
    var heart2 : SKSpriteNode?
    var heart3 : SKSpriteNode?
    var winning : String?
    var currentAnswer : String?
    var lifes : Int!
    var gameoverBoard : SKSpriteNode?
    var backBoard : SKSpriteNode?
    
    var dragonFrames : [SKTexture] = []
    var dragonEvilFrames : [SKTexture]  = []
    
    
    
    override func didMove(to view: SKView) {
        
        //        // Get label node from scene and store it for use later
        //        self.label = self.childNode(withName: "//helloLabel") as? SKLabelNode
        //        if let label = self.label {
        //            label.alpha = 0.0
        //            label.run(SKAction.fadeIn(withDuration: 2.0))
        //        }
        //
        
        
        self.board1 = self.childNode(withName: "board1") as? SKSpriteNode
        self.board2 = self.childNode(withName: "board2") as? SKSpriteNode
        self.board3 = self.childNode(withName: "board3") as? SKSpriteNode
        self.board4 = self.childNode(withName: "board4") as? SKSpriteNode
        self.question = self.childNode(withName: "question") as? SKSpriteNode
        
        
        self.heart = self.childNode(withName: "heart")   as? SKSpriteNode
        self.heart2 = self.childNode(withName: "heart2")   as? SKSpriteNode
        self.heart3 = self.childNode(withName: "heart3")   as? SKSpriteNode
        
        self.dragon = self.childNode(withName: "dragon")    as? SKSpriteNode
        self.frage = question?.childNode(withName: "frage") as? SKLabelNode
        
        self.antwort = board1?.childNode(withName: "antwort") as? SKLabelNode
        self.antwort2 = board2?.childNode(withName: "antwort2") as? SKLabelNode
        self.antwort3 = board3?.childNode(withName: "antwort3") as? SKLabelNode
        self.antwort4 = board4?.childNode(withName: "antwort4") as? SKLabelNode
        self.gameoverBoard = self.childNode(withName: "gameoverBoard") as? SKSpriteNode
        self.backBoard = self.childNode(withName: "backBoard") as? SKSpriteNode
        lifes = 3
        
        buildDragon()
        buildEvilDragon()
        animateDragon()
        
        
        
        
        
        makeQuiz()
        
        let backgroundMusic = SKAudioNode(fileNamed: "sky-loop.wav")
        backgroundMusic.autoplayLooped = true
        addChild(backgroundMusic)
        
        
        
        
    }
    
    var movableNode : SKNode?
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            let location = touch.location(in: self)
            
            if(lifes == -1){
                gameoverBoard?.isHidden = false
                backBoard?.isHidden = false
                if(gameoverBoard?.contains(location))!{
                    newGame()
                }
                if(backBoard?.contains(location))!{
                    removeFeedMeView()
                }
                
            }else{
                gameoverBoard?.isHidden = true
                backBoard?.isHidden = true
                
                if  (board1?.contains(location))!{
                    movableNode = board1
                    currentAnswer = antwort?.text
                    originalPosition = movableNode?.position
                    movableNode!.position = location
                }
                if  (board2?.contains(location))!{
                    movableNode = board2
                    currentAnswer = antwort2?.text
                    originalPosition = movableNode?.position
                    movableNode!.position = location
                }
                if  (board3?.contains(location))!{
                    movableNode = board3
                    currentAnswer = antwort3?.text
                    originalPosition = movableNode?.position
                    movableNode!.position = location
                }
                if  (board4?.contains(location))!{
                    movableNode = board4
                    currentAnswer = antwort4?.text
                    originalPosition = movableNode?.position
                    movableNode!.position = location
                }
                
                
                run(SKAction.playSoundFileNamed("beeps.wav", waitForCompletion: false))
                
            }
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first, movableNode != nil {
            movableNode!.position = touch.location(in: self)
            
        }
        
    }
    
    
    
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first, movableNode != nil {
            movableNode!.position = touch.location(in: self)
            
            if (dragon?.frame.contains((movableNode?.position)!))!{
                
                movableNode?.position = originalPosition!
                
                checkWinning()
                
                if(lifes != -1){
                    makeQuiz()
                }
                
            }
            
            movableNode?.position = originalPosition!
            
            
            movableNode = nil
            
            
            
            
        }
    }
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        if touches.first != nil {
            movableNode = nil
        }
    }
    //    Mathe
    
    func makeQuiz(){
        gameoverBoard?.isHidden = true
        backBoard?.isHidden = true
        
        //        if lifes == -1{
        //
        //            gameoverBoard?.isHidden = false
        //
        //
        //
        //        }
        
        var answerArray = [Int(arc4random_uniform(1001)),Int(arc4random_uniform(1001)),
                           Int(arc4random_uniform(1001)),Int(arc4random_uniform(1001))]
        
        let a = arc4random_uniform(101)
        let b = arc4random_uniform(101)
        
        
        
        let locationCorrect = Int(arc4random_uniform(4))
        
        let correct = Int(a*b)
        winning = String(correct)
        
        
        answerArray[locationCorrect] = correct
        
        let questionString = "\(a) x \(b) "
        
        frage?.text = questionString
        
        antwort?.text = String(answerArray[0])
        antwort2?.text = String(answerArray[1])
        antwort3?.text = String(answerArray[2])
        antwort4?.text = String(answerArray[3])
        
        
        
    }
    func checkWinning(){
        print(lifes)
        
        if currentAnswer != winning {
            run(SKAction.playSoundFileNamed("wrong.wav", waitForCompletion: false))
            switch lifes{
            case 3:
                heart3?.run(SKAction.fadeOut(withDuration: 1.0))
                lifes = 2
                break
            case 2:
                heart2?.run(SKAction.fadeOut(withDuration: 1.0))
                lifes = 1
                break
            case 1:
                heart?.run(SKAction.fadeOut(withDuration: 1.0))
                lifes = 0
                animateDragon()
                
                
                
                break
            case 0:
                run(SKAction.playSoundFileNamed("gameOver.wav", waitForCompletion: false))
                
                lifes = -1
                antwort?.text = ""
                antwort2?.text = ""
                antwort3?.text = ""
                antwort4?.text = ""
                frage?.text = "Game Over"
                gameoverBoard?.isHidden = false
                backBoard?.isHidden = false
                break
                
                
            default:
                print("lose")
            }
            
            
        }
        if currentAnswer == winning{
            run(SKAction.playSoundFileNamed("correct.wav", waitForCompletion: false))
        }
        
    }
    
    func newGame(){
        
        makeQuiz()
        gameoverBoard?.isHidden = true
        backBoard?.isHidden = true
        var actions = Array<SKAction>();
        actions.append(SKAction.wait(forDuration: TimeInterval(0.5)))
        actions.append(SKAction.playSoundFileNamed("newPower.wav", waitForCompletion: false))
        let sequence = SKAction.sequence(actions);
        run(sequence)
        
        heart?.run(SKAction.fadeIn(withDuration: 2.0))
        heart2?.run(SKAction.fadeIn(withDuration: 2.0))
        heart3?.run(SKAction.fadeIn(withDuration: 2.0))
        lifes = 3
        animateDragon()
        //      run(SKAction.playSoundFileNamed("newPower.wav", waitForCompletion: false))
        
        
        
    }
    
    func removeFeedMeView(){
        let nc = NotificationCenter.default
        nc.post(name: NSNotification.Name("exitGame"), object: nil)
    }
    
    func buildDragon(){
        
        let dragonAnimatedAtlas = SKTextureAtlas(named: "DragonImages")
        var flyFrames: [SKTexture] = []
        
        let numImages = dragonAnimatedAtlas.textureNames.count
        for i in 1...numImages {
            let dragonTextureName = "dragon\(i)"
            flyFrames.append(dragonAnimatedAtlas.textureNamed(dragonTextureName))
        }
        dragonFrames = flyFrames
        
        
        
        
        
    }
    
    
    func buildEvilDragon(){
        let dragonEvilAnimatedAtlas = SKTextureAtlas(named: "EvilDragonImages")
        var flyFrames: [SKTexture] = []
        
        let numImages = dragonEvilAnimatedAtlas.textureNames.count
        for i in 1...numImages {
            let dragonTextureName = "dragonEvil\(i)"
            flyFrames.append(dragonEvilAnimatedAtlas.textureNamed(dragonTextureName))
        }
        dragonEvilFrames = flyFrames
        
        
    }
    
    func animateDragon() {
        if lifes > 1{
            dragon?.run(SKAction.repeatForever(
                SKAction.animate(with: dragonFrames,
                                 timePerFrame: 0.5,
                                 resize: false,
                                 restore: true)),
                        withKey:"walkingInPlaceDragon")
            dragon?.xScale = 0.8
        } else {
            dragon?.run(SKAction.repeatForever(
                SKAction.animate(with: dragonEvilFrames,
                                 timePerFrame: 0.5,
                                 resize: false,
                                 restore: true)),
                        withKey:"walkingInPlaceDragon")
            dragon?.xScale  = 1.0
        }
    }
    
    
    
    
    
}
