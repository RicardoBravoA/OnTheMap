//
//  RectangkeButton.swift
//  OnTheMap
//
//  Created by Ricardo Bravo on 29/06/21.
//

import UIKit

class RectangleButton: UIButton {
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        layer.cornerRadius = 5
        tintColor = UIColor.white
        backgroundColor = UIColor.systemBlue
    }
    
}
