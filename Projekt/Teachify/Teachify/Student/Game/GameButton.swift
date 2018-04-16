//
//  GameButton.swift
//  Teachify
//
//  Created by Normen Krug on 11.04.18.
//  Copyright © 2018 Christian Pfeiffer. All rights reserved.
//

import Foundation
import SpriteKit

class BasicButton: SKSpriteNode{
    
    var label: SKLabelNode!
    var buttonAction: () -> Void
    var leftConstraint: SKConstraint!
    var middleConstraint: SKConstraint!
    var rightConstraint: SKConstraint!
    
    init(texture: SKTexture?, color: UIColor, size: CGSize,action: @escaping () -> Void, text: String, fontColor: UIColor) {
        buttonAction = action
        super.init(texture: texture, color: color, size: size)
        label = SKLabelNode(text: text)
        label.fontSize = 40
        label.fontColor = fontColor
        label.position = CGPoint(x: self.position.x, y: self.position.y - 13)
        self.addChild(label)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func changeText(input: String){
        
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        print("moved")
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        print("began")
        buttonAction()
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        print("end")
    }
    
}
