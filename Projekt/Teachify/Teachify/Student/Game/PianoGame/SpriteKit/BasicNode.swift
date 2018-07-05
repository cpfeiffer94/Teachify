//
//  GameButton.swift
//  Teachify
//
//  Created by Normen Krug on 11.04.18.
//  Copyright © 2018 Christian Pfeiffer. All rights reserved.
//

import Foundation
import SpriteKit

class BasicNode: SKSpriteNode{
    
    var label: SKLabelNode!
    var nodeTexture: SKTexture!
    var nodeColor: UIColor!
    var nodeSize: CGSize!
    var nodeText: String!
    var nodeFontColor: UIColor!
    var nodeImageName: String!

    init(texture: SKTexture?, color: UIColor, size: CGSize, text: String, fontColor: UIColor, imageName: String) {
        super.init(texture: texture, color: color, size: size)
        nodeTexture = texture
        nodeColor = color
        nodeSize = size
        nodeText = text
        nodeFontColor = fontColor
        nodeImageName = imageName
        
        self.texture = SKTexture(imageNamed: imageName)
        
        label = SKLabelNode(text: text)
        label.fontSize = 40
        label.fontColor = fontColor
        label.fontName = "AvenirNext-Bold"
        label.position = CGPoint(x: self.position.x, y: self.position.y - 13)
        
        self.addChild(label)
        
       
    }
    init(texture: SKTexture?, color: UIColor, size: CGSize, fontColor: UIColor, text: String) {
        super.init(texture: texture, color: color, size: size)
        let shape = SKShapeNode()
        shape.path = UIBezierPath(roundedRect: CGRect(x: self.position.x - size.width/2, y: self.position.y - size.height/2, width: size.width, height: size.height), cornerRadius: 10).cgPath
        shape.position = CGPoint(x: frame.midX, y: frame.midY)
        shape.fillColor = color
        shape.lineWidth = 10
        addChild(shape)
        
        label = SKLabelNode(text: text)
        label.fontSize = 40
        label.fontColor = fontColor
        label.fontName = "AvenirNext-Bold"
        label.position = CGPoint(x: self.position.x, y: self.position.y - 13)
        self.addChild(label)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
    }
    
}
