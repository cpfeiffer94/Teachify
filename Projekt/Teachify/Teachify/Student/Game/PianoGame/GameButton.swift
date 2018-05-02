//
//  GameButton.swift
//  Teachify
//
//  Created by Normen Krug on 11.04.18.
//  Copyright © 2018 Christian Pfeiffer. All rights reserved.
//

import Foundation
import SpriteKit

protocol BasicButtonDelegate: class {
    func basicButtonPressed(_ button: BasicButton)
}

class BasicButton: SKSpriteNode{
    
    weak var delegate: BasicButtonDelegate?

    
    var label: SKLabelNode!
    var leftConstraint: SKConstraint!
    var middleConstraint: SKConstraint!
    var rightConstraint: SKConstraint!
    
    init(texture: SKTexture?, color: UIColor, size: CGSize, text: String, fontColor: UIColor) {
        
       
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
        print("moved")
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        let scale = SKAction.scale(to: 0.7, duration: 0.2)
        self.run(scale)
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        let scale = SKAction.scale(to: 1, duration: 0.2)
        self.run(scale)
        delegate?.basicButtonPressed(self)
    }
    
}
