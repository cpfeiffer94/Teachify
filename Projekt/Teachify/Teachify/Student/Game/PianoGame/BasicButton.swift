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
