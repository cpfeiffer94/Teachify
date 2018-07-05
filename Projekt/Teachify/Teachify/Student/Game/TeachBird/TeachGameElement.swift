//
//  TeachGameElement.swift
//  Teachify
//
//  Created by Christian Pöhlmann on 21.06.18.
//  Copyright © 2018 Christian Pfeiffer. All rights reserved.
//

import SpriteKit

struct CollisionBitMask {
    static let birdCategory:UInt32 = 0x1 << 0
    static let answareCategory:UInt32 = 0x1 << 1
    static let flowerCategory:UInt32 = 0x1 << 2
    static let groundCategory:UInt32 = 0x1 << 3
    static let corectAnswareCategory:UInt32 = 0x1 << 4
    
}

extension TeachGameScene{
    func createBird() -> SKSpriteNode {
        let bird = SKSpriteNode(imageNamed: "bird1")
        bird.size = CGSize(width: 55, height: 50)
        bird.position = CGPoint(x:self.frame.midX - 200, y:self.frame.midY)
        bird.zPosition=4
        
        bird.physicsBody = SKPhysicsBody(circleOfRadius: bird.size.width / 2)
        bird.physicsBody?.linearDamping = 1.1
        bird.physicsBody?.restitution = 0
        bird.physicsBody?.categoryBitMask = CollisionBitMask.birdCategory
        bird.physicsBody?.collisionBitMask = CollisionBitMask.answareCategory | CollisionBitMask.groundCategory
        bird.physicsBody?.contactTestBitMask = CollisionBitMask.answareCategory | CollisionBitMask.flowerCategory | CollisionBitMask.groundCategory | CollisionBitMask.corectAnswareCategory
        bird.physicsBody?.affectedByGravity = false
        bird.physicsBody?.isDynamic = true
        return bird
    }
    func createRestartBtn() {
        restartBtn = SKSpriteNode(imageNamed: "restart")
        restartBtn.size = CGSize(width:100, height:100)
        restartBtn.position = CGPoint(x: self.frame.width / 2, y: self.frame.height / 2)
        restartBtn.zPosition = 6
        restartBtn.setScale(0)
        self.addChild(restartBtn)
        restartBtn.run(SKAction.scale(to: 1.0, duration: 0.3))
    }
    func createPauseBtn() {
        pauseBtn = SKSpriteNode(imageNamed: "pause")
        pauseBtn.size = CGSize(width:40, height:40)
        pauseBtn.position = CGPoint(x: self.frame.width - 30, y: 30)
        pauseBtn.zPosition = 6
        self.addChild(pauseBtn)
    }
    func createScoreLabel() -> SKLabelNode {
        let scoreLbl = SKLabelNode()
        //scoreLbl.position = CGPoint(x: self.frame.width / 2, y: self.frame.height / 2 + self.frame.height / 2.6)
        scoreLbl.position = CGPoint(x: self.frame.width / 8, y: self.frame.height / 2 + self.frame.height / 2.6)
        scoreLbl.text = "\(score)"
        scoreLbl.zPosition = 5
        scoreLbl.fontSize = 50
        scoreLbl.fontName = "HelveticaNeue-Bold"
        
        let scoreBg = SKShapeNode()
        scoreBg.position = CGPoint(x: 0, y: 0)
        scoreBg.path = CGPath(roundedRect: CGRect(x: CGFloat(-50), y: CGFloat(-30), width: CGFloat(100), height: CGFloat(100)), cornerWidth: 50, cornerHeight: 50, transform: nil)
        let scoreBgColor = UIColor(red: CGFloat(0.0 / 255.0), green: CGFloat(0.0 / 255.0), blue: CGFloat(0.0 / 255.0), alpha: CGFloat(0.2))
        scoreBg.strokeColor = UIColor.clear
        scoreBg.fillColor = scoreBgColor
        scoreBg.zPosition = -1
        scoreLbl.addChild(scoreBg)
        return scoreLbl
    }
    func createHighscoreLabel() -> SKLabelNode {
        let highscoreLbl = SKLabelNode()
        highscoreLbl.position = CGPoint(x: self.frame.width - 80, y: self.frame.height - 22)
        if let highestScore = UserDefaults.standard.object(forKey: "highestScore"){
            highscoreLbl.text = "Highest Score: \(highestScore)"
        } else {
            highscoreLbl.text = "Highest Score: 0"
        }
        highscoreLbl.zPosition = 5
        highscoreLbl.fontSize = 15
        highscoreLbl.fontName = "Helvetica-Bold"
        return highscoreLbl
    }
    func createLogo() {
        logoImg = SKSpriteNode()
        logoImg = SKSpriteNode(imageNamed: "logo")
        logoImg.name = "logo"
        logoImg.size = CGSize(width: 272, height: 65)
        logoImg.position = CGPoint(x:self.frame.midX, y:self.frame.midY + 70)
        logoImg.setScale(0.5)
        self.addChild(logoImg)
        logoImg.run(SKAction.scale(to: 1.0, duration: 0.3))
    }
    func createTaptoplayLabel() -> SKLabelNode {
        let taptoplayLbl = SKLabelNode()
        taptoplayLbl.position = CGPoint(x:self.frame.midX, y:self.frame.midY - 100)
        taptoplayLbl.text = "Tap anywhere to play"
        taptoplayLbl.fontColor = UIColor(red: 63/255, green: 79/255, blue: 145/255, alpha: 1.0)
        taptoplayLbl.fontColor = UIColor.green
        taptoplayLbl.zPosition = 5
        taptoplayLbl.fontSize = 20
        taptoplayLbl.fontName = "HelveticaNeue"
        return taptoplayLbl
    }
    func createLeben(){
        for i in 0..<aktuelleLeben {
            let leben=SKSpriteNode(imageNamed: "leben")
            leben.size=CGSize(width: 30, height: 30)
            leben.position=CGPoint(x: self.frame.width - CGFloat(40 * (i+1)), y: self.frame.height-40)
            leben.zPosition=7
            self.addChild(leben)
        }
    }
    func createLabl(name:String, position:CGPoint,tamplate: Bool) ->SKLabelNode{
        let lable = SKLabelNode()
        lable.text=name
        lable.fontName="HelveticaNeue"
        lable.fontSize=50
        let aColor = UIColor(red: 0/255, green: 130/255, blue: 48/255, alpha: 1.0)
        if tamplate{ lable.fontColor=aColor } else {
            lable.fontColor=UIColor.darkGray }
        lable.position=position
        lable.verticalAlignmentMode = .center
        var lableBK = SKSpriteNode()
        if tamplate{
            lableBK = SKSpriteNode(imageNamed: "wolke")
        } else {
            lableBK = SKSpriteNode(imageNamed: "wolk") }
        lableBK.size=CGSize(width: 360, height: 70)
        lableBK.zPosition = -1
        lable.addChild(lableBK)
        return lable
    }
    func createWalls() -> SKNode  {
        let flowerNode = SKSpriteNode(imageNamed: "worm")
        flowerNode.size = CGSize(width: 40, height: 40)
        flowerNode.position = CGPoint(x: self.frame.width + 300, y: self.frame.height / 2)
        flowerNode.physicsBody = SKPhysicsBody(rectangleOf: flowerNode.size)
        flowerNode.physicsBody?.affectedByGravity = false
        flowerNode.physicsBody?.isDynamic = false
        flowerNode.physicsBody?.categoryBitMask = CollisionBitMask.flowerCategory
        flowerNode.physicsBody?.collisionBitMask = 0
        flowerNode.physicsBody?.contactTestBitMask = CollisionBitMask.birdCategory
        flowerNode.color = SKColor.blue
        let randomPosition = random(min: -100, max: 100)
        wallPair = SKNode()
        wallPair.name = "wallPair"
        let position=CGPoint(x: 200 , y: 45 - randomPosition)
        let vok=createLabl(name: self.data.getTask(number: aTask)[0], position: position,tamplate: true)
        wallPair.addChild(vok)
        vok.run(andRemove)
        
        let elem=createRandom(to: 4)
        var index=1
        for i in elem {
            let move:Int = 150 * index
            let randP = random(min: 350, max: 750)
            index += 1
            let position=CGPoint(x: self.frame.width / 2 + randP, y: self.frame.height - CGFloat(move))
            let loes=createLabl(name: data.getTask(number: aTask)[i], position: position,tamplate: false)
            if i == 1{
                loes.physicsBody = SKPhysicsBody(edgeLoopFrom: CGRect(x: -155, y: -30, width: 320, height: 50))
                loes.physicsBody?.categoryBitMask = CollisionBitMask.corectAnswareCategory
                loes.physicsBody?.collisionBitMask = 0
            } else{
                loes.physicsBody = SKPhysicsBody(edgeLoopFrom: CGRect(x: -155, y: -30, width: 320, height: 50))
                loes.physicsBody?.categoryBitMask = CollisionBitMask.answareCategory
                loes.physicsBody?.collisionBitMask = CollisionBitMask.birdCategory
            }
            loes.physicsBody?.contactTestBitMask = CollisionBitMask.birdCategory
            loes.physicsBody?.isDynamic = false
            loes.physicsBody?.affectedByGravity = false
            wallPair.addChild(loes)
        }
        aTask=aTask+1
        wallPair.zPosition = 1
        
        wallPair.position.y = wallPair.position.y +  randomPosition
        wallPair.addChild(flowerNode)
        
        wallPair.run(moveAndRemove)
        return wallPair
    }
    func random() -> CGFloat{
        return CGFloat(Float(arc4random()) / 0xFFFFFFFF)
    }
    func random(min : CGFloat, max : CGFloat) -> CGFloat{
        return random() * (max - min) + min
    }
    func createRandom(to:Int)->[Int]{
        var item:[Int]=[]
        for i in 1...to {
            item.append(i)
        }
        var shuffled:[Int]=[]
        for i in 1...to {
            let z = Int(arc4random_uniform(UInt32(to-i)+1))
            shuffled.append(item[z])
            item.remove(at:z)
        }
        return shuffled
    }
    func createSwitchNavigationBtn(image :String){
        switchNavigationBtn=SKSpriteNode(imageNamed: image)
        switchNavigationBtn.size=CGSize(width: 60, height: 60)
        switchNavigationBtn.position=CGPoint(x: self.frame.width - 100, y: 50)
        switchNavigationBtn.zPosition = 6
        self.addChild(switchNavigationBtn)
    }
    func createNavigationLable(image :String){
        navigationLbl=SKSpriteNode(imageNamed: image)
        navigationLbl.size=CGSize(width: 40, height: 40)
        navigationLbl.position=CGPoint(x: self.frame.width - 180, y: self.frame.height - 22)
        navigationLbl.zPosition = 6
        self.addChild(navigationLbl)
    }
    func createBackBtn() {
        backBtn = SKSpriteNode(imageNamed: "back")
        backBtn.size = CGSize(width:150, height:150)
        backBtn.position = CGPoint(x: 100, y: self.frame.midY - 300)
        backBtn.zPosition = 6
        backBtn.setScale(0)
        self.addChild(backBtn)
        backBtn.run(SKAction.scale(to: 1.0, duration: 0.3))
    }
}

class TeachGameElement: SKScene {
    
}

