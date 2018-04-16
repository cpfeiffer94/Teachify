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
    
    init(texture: SKTexture?, color: UIColor, size: CGSize,action: @escaping () -> Void, text: String) {
        buttonAction = action
        super.init(texture: texture, color: color, size: size)
        label = SKLabelNode(text: String(text))
        label.position = CGPoint(x: self.position.x, y: self.position.y - 10)
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
