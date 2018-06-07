//
//  GameButton.swift
//  Teachify
//
//  Created by Normen Krug on 02.05.18.
//  Copyright © 2018 Christian Pfeiffer. All rights reserved.
//

import Foundation
import SpriteKit

protocol BasicButtonDelegate: class {
    func basicButtonPressed(_ button: BasicButton)
}

class BasicButton: BasicNode{
    
    weak var delegate: BasicButtonDelegate?
    var moved: Bool!
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        let bigTouches = touches.filter{abs($0.location(in: self).x) > 20 && abs($0.location(in: self).y) > 20 }
        if bigTouches.count != 0{
            moved = true
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        moved = false
        super.touchesBegan(touches, with: event)
        let scale = SKAction.scale(to: 0.7, duration: 0.2)
        self.run(scale)
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        let scale = SKAction.scale(to: 1, duration: 0.2)
        self.run(scale)
        if !moved{
            delegate?.basicButtonPressed(self)
        }
    }
}
