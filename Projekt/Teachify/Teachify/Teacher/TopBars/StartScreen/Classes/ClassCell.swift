//
//  ClassCell.swift
//  Teachify
//
//  Created by Bastian Kusserow on 10.04.18.
//  Copyright © 2018 Christian Pfeiffer. All rights reserved.
//

import UIKit

class ClassCell: UICollectionViewCell{
    
    var delegate : CellMenuDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    private func setup(){
        let gestureRecognizer = UILongPressGestureRecognizer(target: self, action: #selector(openMenu(_:)))
        gestureRecognizer.minimumPressDuration = 1.0
        self.addGestureRecognizer(gestureRecognizer)
    }
    
    @objc private func openMenu(_ gestureRecognizer: UILongPressGestureRecognizer){
        if gestureRecognizer.state == .began {
        let actionSheet = UIAlertController(title: "Aktionen", message: "Wollen Sie die Klasse wirklich löschen?", preferredStyle: .actionSheet)
        actionSheet.addAction(UIAlertAction(title: "Löschen", style: .destructive, handler: { [unowned self] (action) in
            self.delegate?.delete(cell: self)
        }))
        
        actionSheet.popoverPresentationController?.sourceView = contentView
        actionSheet.popoverPresentationController?.sourceRect=contentView.frame
        UIApplication.shared.keyWindow?.visibleViewController()?.present(actionSheet, animated: true, completion: nil)
        }
    }
    
    @IBOutlet var className: UILabel!
    @IBOutlet var rightImageView: UIImageView!  {
        didSet{
            rightImageView.layer.borderWidth = 1
            rightImageView.layer.borderColor = UIColor.rgb(red: 55, green: 105, blue: 182).cgColor
        }
    }
    @IBOutlet var middleImageView: UIImageView!{
        didSet{
            middleImageView.layer.borderWidth = 1
            middleImageView.layer.borderColor = UIColor.rgb(red: 55, green: 105, blue: 182).cgColor
        }
    }
    
    @IBOutlet var leftImageView: UIImageView!{
        didSet{
            leftImageView.layer.borderWidth = 1
            leftImageView.layer.borderColor = UIColor.rgb(red: 55, green: 105, blue: 182).cgColor
        }
    }
    
    override var isSelected: Bool {
        didSet{
            className.font = isSelected ? UIFont.boldSystemFont(ofSize: className.font.pointSize) : UIFont.systemFont(ofSize: className.font.pointSize)
        }
    }
    
    override var isHighlighted: Bool {
        didSet{
            className.font = isSelected ? UIFont.boldSystemFont(ofSize: className.font.pointSize) : UIFont.systemFont(ofSize: className.font.pointSize)
        }
    }
}
