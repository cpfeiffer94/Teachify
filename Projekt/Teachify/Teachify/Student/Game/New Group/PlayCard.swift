//
//  PlayCard.swift
//  Teachify
//
//  Created by Normen Krug on 19.04.18.
//  Copyright © 2018 Christian Pfeiffer. All rights reserved.
//

import Foundation
import SpriteKit

class PlayCard: SKSpriteNode{
    
    fileprivate var identifier: Int
    
    init(texture: SKTexture?, color: UIColor, size: CGSize, identi: Int) {
        self.identifier = identi
        super.init(texture: texture,color: color,size: size)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
    //  event?.setValue(Any?, forKey: <#T##String#>) set identifier
        super.touchesBegan(touches, with: event)
    }
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesMoved(touches, with: event)
    }
    
}
