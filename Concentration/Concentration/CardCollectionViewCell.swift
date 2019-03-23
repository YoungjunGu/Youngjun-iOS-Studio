//
//  CardCollectionViewCell.swift
//  Concentration
//
//  Created by youngjun goo on 22/03/2019.
//  Copyright © 2019 youngjun goo. All rights reserved.
//

import UIKit

class CardCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var cardButton: UIButton!
    var selectCard = ""
    
    @IBAction func touchUpCard(_ sender: UIButton) {
        let VC = UIViewController.self as? ViewController
        
        selectCard = (sender.titleLabel?.text)!
        VC?.selectCard = selectCard
        
        if selectCard == VC?.selectCard {
            cardSetting(withEmoji: selectCard, on: sender)
        } else {
            cardSetting(withEmoji: selectCard, on: sender)
        }
        
    }
    
    fileprivate func cardSetting(withEmoji emoji: String, on button: UIButton) {
        if button.currentTitle == emoji {
            button.setTitle("", for: .normal)
            button.backgroundColor = UIColor.orange
        } else {
            button.setTitle(emoji, for: .normal)
            button.backgroundColor = UIColor.white
        }
        
    }
    

    
}
