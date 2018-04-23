//
//  GameCardCell.swift
//  Teachify
//
//  Created by Christian Pfeiffer on 12.04.18.
//  Copyright © 2018 Christian Pfeiffer. All rights reserved.
//

import UIKit
import Cards

class GameCardCell: UICollectionViewCell {
    let card = CardHighlight(frame: CGRect(x: 0, y: 0, width: 600 , height: 400))
    
    @IBOutlet weak var view: CardHighlight!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        card.delegate = self
    }
    
}

extension GameCardCell: CardDelegate {
    
    func cardDidTapInside(card: Card) {
        print("i got Tapped 1")
    }
    
    func cardHighlightDidTapButton(card: CardHighlight, button: UIButton) {
        print("i got Tapped 2")
        NotificationCenter.default.post(name: .startGame , object: nil)
    }
    
}
