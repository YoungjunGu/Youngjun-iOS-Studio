//
//  RoundedWhiteButton.swift
//  GroupTalk
//
//  Created by youngjun goo on 09/02/2019.
//  Copyright © 2019 youngjun goo. All rights reserved.
//

import Foundation
import UIKit



@IBDesignable class RoundedWhiteButton: UIButton {
    
    var highlightedColor = UIColor.white {
        didSet {
            if isHighlighted {
                backgroundColor = highlightedColor
            }
        }
    }
    
    var defaultColor = UIColor.clear {
        didSet {
            if !isHighlighted {
                backgroundColor = defaultColor
            }
        }
    }
    
    override var isHighlighted: Bool {
        didSet {
            if isHighlighted {
                backgroundColor = highlightedColor
            } else {
                backgroundColor = defaultColor
            }
        }
    }
    
    func setup() {
        self.layer.borderColor = UIColor.white.cgColor
        self.layer.borderWidth = 2.0
        self.layer.cornerRadius = self.frame.height / 2
        self.clipsToBounds = true
    }
    
    @IBInspectable var rounded: Bool = false {
        didSet {
            setup()
        }
    }
    
}

