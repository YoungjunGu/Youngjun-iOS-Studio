//
//  ViewController.swift
//  Concentration
//
//  Created by youngjun goo on 15/03/2019.
//  Copyright © 2019 youngjun goo. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBAction func touchUpCard(_ sender: UIButton) {
        cardSetting(whitEmoji: "👻", on: sender)
    }
    
    fileprivate func cardSetting(whitEmoji emoji: String, on button: UIButton) {
        if button.currentTitle == emoji {
            button.setTitle("", for: .normal)
            button.backgroundColor = UIColor.orange
        } else {
            button.setTitle(emoji, for: .normal)
            button.backgroundColor = UIColor.white
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }


}

