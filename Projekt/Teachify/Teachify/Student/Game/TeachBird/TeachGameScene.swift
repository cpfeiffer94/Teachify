//
//  TeachGameScene.swift
//  Teachify
//
//  Created by Christian Pöhlmann on 21.06.18.
//  Copyright © 2018 Christian Pfeiffer. All rights reserved.
//

import SpriteKit
import GameplayKit

class TeachGameScene: SKScene, SKPhysicsContactDelegate {
    var isGameStarted = Bool(false)
    var isDied = Bool(false)
    let coinSound = SKAction.playSoundFileNamed("CoinSound.mp3", waitForCompletion: false)
    let diedSound = SKAction.playSoundFileNamed("DiedSound.mp3", waitForCompletion: false)
    
    var score = Int(0)
    var scoreLbl = SKLabelNode()
    var highscoreLbl = SKLabelNode()
    var taptoplayLbl = SKLabelNode()
    var restartBtn = SKSpriteNode()
    var pauseBtn = SKSpriteNode()
    var switchNavigationBtn=SKSpriteNode()
    var navigationLbl=SKSpriteNode()
    var logoImg = SKSpriteNode()
    var wallPair = SKNode()
    var moveAndRemove = SKAction()
    var andRemove=SKAction()
    
    var birdSprites: [SKTexture]=[]
    var bird = SKSpriteNode()
    var repeatActionBird = SKAction()
    
    let data=TeachDataModle()
    var label=SKLabelNode()
    //var allLeben:[SKNode]=[]
    var aktuelleLeben=3
    var aTask=0
    
    var sensor = TeachSensoring()
    var sensorAktive=false
    var inMenue=true
    var trestart=true
    var bkPosition=CGPoint()
    var aGestellteAufgabe=0
    
    
    override func didMove(to view: SKView) {
        createScene()
        sensor.setGame(game: self as! NSObject)
        
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches{
            let location = touch.location(in: self)
            if !switchNavigationBtn.contains(location) && trestart {
                trestart=false
                startdedGame()
            }
            if isDied == true{
                if restartBtn.contains(location){
                    if UserDefaults.standard.object(forKey: "highestScore") != nil {
                        let hscore = UserDefaults.standard.integer(forKey: "highestScore")
                        if hscore < Int(scoreLbl.text!)!{
                            UserDefaults.standard.set(scoreLbl.text, forKey: "highestScore")
                        }
                    } else {
                        UserDefaults.standard.set(0, forKey: "highestScore")
                    }
                    restartScene()
                    if aktuelleLeben != 3{
                        startdedGame()
                    } else{
                        trestart=true
                    }
                }
            } else {
                if pauseBtn.contains(location){
                    if self.isPaused == false{
                        self.isPaused = true
                        pauseBtn.texture = SKTexture(imageNamed: "play")
                    } else {
                        self.isPaused = false
                        pauseBtn.texture = SKTexture(imageNamed: "pause")
                    }
                }
                if !trestart{
                    startdedGame()
                    if sensorAktive && inMenue{
                        sensor.startDeviceMotion()
                        inMenue=false
                    }
                }
            }
            if switchNavigationBtn.contains(location){
                if !self.sensorAktive {
                    self.sensorAktive=true
                    switchNavigationBtn.texture=SKTexture(imageNamed: "touch")
                    navigationLbl.texture=SKTexture(imageNamed: "rotatel")
                    animateBackground()
                }else{
                    self.sensorAktive=false
                    switchNavigationBtn.texture=SKTexture(imageNamed: "rotate")
                    navigationLbl.texture=SKTexture(imageNamed: "touchl")
                }
            }
            
        }
    }
    func setNavigationButton(){
        if self.sensorAktive {
            createSwitchNavigationBtn(image: "touch")
            createNavigationLable(image: "rotatel")
        } else {
            createSwitchNavigationBtn(image: "rotate")
            createNavigationLable(image: "touchl")
        }
    }
    func animateBackground(){
        sensor.startBackgroound()
        enumerateChildNodes(withName: "logo", using: ({
            (node, error) in
            let bg = node as! SKSpriteNode
            self.bkPosition=bg.position
        }))
    }
    func moveBackground(x:Double,y:Double){
        if inMenue && sensorAktive{
            enumerateChildNodes(withName: "logo", using: ({
                (node, error) in
                let bg = node as! SKSpriteNode
                bg.position = CGPoint(x: self.bkPosition.x + CGFloat(x), y: self.bkPosition.y + CGFloat(y))
            }))
        }else{
            sensor.stopBackgroundMotion()
            enumerateChildNodes(withName: "logo", using: ({
                (node, error) in
                let bg = node as! SKSpriteNode
                bg.position = self.bkPosition
            }))
        }
    }
    func startdedGame(){
        if isGameStarted == false{
            isGameStarted =  true
            bird.physicsBody?.affectedByGravity = true
            createPauseBtn()
            
            logoImg.run(SKAction.scale(to: 0.5, duration: 0.0), completion: {
                self.logoImg.removeFromParent()
            })
            taptoplayLbl.removeFromParent()
            self.bird.run(repeatActionBird)
            
            let spawn = SKAction.run({
                () in
                self.wallPair = self.createWalls()
                if self.aGestellteAufgabe>self.data.corectAnsware{
                    if self.score >= 2{
                        self.score -= 2
                        self.scoreLbl.text = "\(self.score)"
                    } else {
                        //TODO to fix
                        //                        self.diedBird()
                        print("----------->RemoveLEBEN Aufgabe wurde nicht gelöst")
                    }
                    self.aGestellteAufgabe = self.data.corectAnsware
                }
                self.aGestellteAufgabe += 1
                self.addChild(self.wallPair)
            })//Warten
            let delay = SKAction.wait(forDuration: 8.0)
            let SpawnDelay = SKAction.sequence([spawn, delay])
            let spawnDelayForever = SKAction.repeatForever(SpawnDelay)
            self.run(spawnDelayForever)
            
            let distance = CGFloat(self.frame.width + wallPair.frame.width)
            let moveElem=SKAction.moveBy(x: -distance-50, y: 0, duration: TimeInterval(0.008*distance))
            let removeElem=SKAction.removeFromParent()
            moveAndRemove=SKAction.sequence([moveElem, removeElem])
            
            let moveElem2=SKAction.moveBy(x: +distance+50, y: 0, duration: TimeInterval(0.0075*distance))
            let removeElem2=SKAction.removeFromParent()
            andRemove=SKAction.sequence([moveElem2, removeElem2])
            
            bird.physicsBody?.velocity = CGVector(dx: 0, dy: 0)
            bird.physicsBody?.applyImpulse(CGVector(dx: 0, dy: 40))
        } else {
            if isDied == false {
                bird.physicsBody?.velocity = CGVector(dx: 0, dy: 0)
                bird.physicsBody?.applyImpulse(CGVector(dx: 0, dy: 40))
            }
        }
    }
    func setBirdposition(xImpise:Double, yImpulse:Double){
        if isDied == false && sensorAktive{
            bird.physicsBody?.velocity = CGVector(dx: 0, dy: 0)
            bird.physicsBody?.applyImpulse(CGVector(dx: xImpise, dy: yImpulse))
        } else {
            sensor.stopDeviceMotion()
        }
    }
    override func update(_ currentTime: TimeInterval) {
        if isGameStarted == true{
            if isDied == false{
                enumerateChildNodes(withName: "background", using: ({
                    (node, error) in
                    let bg = node as! SKSpriteNode
                    bg.position = CGPoint(x: bg.position.x - 2, y: bg.position.y)
                    if bg.position.x <= -bg.size.width {
                        bg.position = CGPoint(x:bg.position.x + bg.size.width * 2, y:bg.position.y)
                    }
                }))
                enumerateChildNodes(withName: "backgroundh", using: ({
                    (node, error) in
                    let bg = node as! SKSpriteNode
                    bg.position = CGPoint(x: bg.position.x - 1.75, y: bg.position.y)
                    if bg.position.x <= -bg.size.width {
                        bg.position = CGPoint(x:bg.position.x + bg.size.width * 2, y:bg.position.y)
                    }
                }))
            }
        }
    }
    func createScene(){
        self.physicsBody = SKPhysicsBody(edgeLoopFrom: self.frame)
        self.physicsBody?.categoryBitMask = CollisionBitMask.groundCategory
        self.physicsBody?.collisionBitMask = CollisionBitMask.birdCategory
        self.physicsBody?.contactTestBitMask = CollisionBitMask.birdCategory
        self.physicsBody?.isDynamic = false
        self.physicsBody?.affectedByGravity = false
        
        self.physicsWorld.contactDelegate = self
        self.backgroundColor = SKColor(red: 80.0/255.0, green: 192.0/255.0, blue: 203.0/255.0, alpha: 1.0)
        for i in 0..<2
        {
            let background = SKSpriteNode(imageNamed: "backgrund")
            background.anchorPoint = CGPoint.init(x: 0, y: 0)
            background.position = CGPoint(x:CGFloat(i) * self.frame.width, y:0)
            background.name = "background"
            background.size = (self.view?.bounds.size)!
            self.addChild(background)
        }
        for i in 0..<2
        {
            let background = SKSpriteNode(imageNamed: "backgrundh")
            background.zPosition = -1
            background.anchorPoint = CGPoint.init(x: 0, y: 0)
            background.position = CGPoint(x:CGFloat(i) * self.frame.width, y:0)
            background.name = "backgroundh"
            background.size = (self.view?.bounds.size)!
            self.addChild(background)
        }
        self.bird = createBird()
        self.addChild(bird)
        
        buildBirdAnimation()
        animateBird()
        
        scoreLbl=createScoreLabel()
        self.addChild(scoreLbl)
        highscoreLbl=createHighscoreLabel()
        self.addChild(highscoreLbl)
        createLogo()
        taptoplayLbl = createTaptoplayLabel()
        self.addChild(taptoplayLbl)
        self.createLeben()
        let bgSound=SKAudioNode(fileNamed: "bkSound.mp3")
        bgSound.autoplayLooped=true
        setNavigationButton()
        addChild(bgSound)
        if sensorAktive && !inMenue{
            sensor.startDeviceMotion()
        }
    }
    func buildBirdAnimation(){
        let birdAtlas = SKTextureAtlas(named:"Bird")
        var birdFrames: [SKTexture] = []
        let numImages = birdAtlas.textureNames.count
        print(numImages)
        for i in 1...numImages{
            let birdTextureName = "bird\(i)"
            birdFrames.append(birdAtlas.textureNamed(birdTextureName))
        }
        birdSprites = birdFrames
    }
    func animateBird(){
        bird.run(SKAction.repeatForever(SKAction.animate(with: birdSprites, timePerFrame: 0.4,resize:false,restore:true)), withKey:"birdShowing")
        //self.repeatActionBird=SKAction.repeatForever(bird)
    }
    func diedBird(){
        enumerateChildNodes(withName: "wallPair", using: ({
            (node, error) in
            node.speed = 0
            self.removeAllActions()
        }))
        if isDied == false{
            isDied = true
            createRestartBtn()
            pauseBtn.removeFromParent()
            self.bird.removeAllActions()
            run(diedSound)
            self.aGestellteAufgabe=data.corectAnsware
        }
    }
    func didBegin(_ contact: SKPhysicsContact) {
        let firstBody = contact.bodyA
        let secondBody = contact.bodyB
        
        if firstBody.categoryBitMask == CollisionBitMask.birdCategory && secondBody.categoryBitMask == CollisionBitMask.answareCategory || firstBody.categoryBitMask == CollisionBitMask.answareCategory && secondBody.categoryBitMask == CollisionBitMask.birdCategory || firstBody.categoryBitMask == CollisionBitMask.birdCategory && secondBody.categoryBitMask == CollisionBitMask.groundCategory || firstBody.categoryBitMask == CollisionBitMask.groundCategory && secondBody.categoryBitMask == CollisionBitMask.birdCategory{
            diedBird()
        } else if (firstBody.categoryBitMask == CollisionBitMask.birdCategory && secondBody.categoryBitMask == CollisionBitMask.flowerCategory)
            //            || (firstBody.categoryBitMask == CollisionBitMask.flowerCategory && secondBody.categoryBitMask == CollisionBitMask.birdCategory)  // Bird wird unsichtbar
        {
            run(coinSound)
            score += 1
            scoreLbl.text = "\(score)"
            secondBody.node?.removeFromParent()
        } else if firstBody.categoryBitMask == CollisionBitMask.flowerCategory && secondBody.categoryBitMask == CollisionBitMask.birdCategory {
            run(coinSound)
            score += 1
            scoreLbl.text = "\(score)"
            firstBody.node?.removeFromParent()
        } else if (firstBody.categoryBitMask == CollisionBitMask.birdCategory && secondBody.categoryBitMask == CollisionBitMask.corectAnswareCategory)
            //            || (firstBody.categoryBitMask == CollisionBitMask.corectAnswareCategory && secondBody.categoryBitMask == CollisionBitMask.birdCategory)
        {
            run(coinSound)
            score += 1
            scoreLbl.text = "\(score)"
            secondBody.node?.removeFromParent()
            data.addCorrectAnsware()
        }
        else if firstBody.categoryBitMask == CollisionBitMask.corectAnswareCategory && secondBody.categoryBitMask == CollisionBitMask.birdCategory {
            run(coinSound)
            score += 1
            scoreLbl.text = "\(score)"
            firstBody.node?.removeFromParent()
            data.addCorrectAnsware()
        }
    }
    func restartScene(){
        self.removeAllChildren()
        self.removeAllActions()
        isDied = false
        isGameStarted = false
        
        if aktuelleLeben > 0{
            aktuelleLeben = aktuelleLeben-1
            inMenue=false
            print(aktuelleLeben)
        } else {
            score = 0
            aktuelleLeben=3
            data.removeCorrectAnsware()
            aGestellteAufgabe=0
            inMenue=true
            print("Game Over")
        }
        createScene()
        if inMenue{
            animateBackground()
        }
    }
    
}
