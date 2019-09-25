//
//  ViewController.swift
//  Bounds&Frame
//
//  Created by youngjun goo on 22/09/2019.
//  Copyright © 2019 youngjun goo. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var redView: UIView!
    @IBOutlet weak var blueView: UIView!
    @IBOutlet weak var changeButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        redView.frame.origin.x = 60
        redView.frame.origin.y = 100
        
        blueView.frame.origin.x = 25
        blueView.frame.origin.y = 200
        
        redView.bounds.origin.x = 50
        redView.bounds.origin.y = 100
        
        print("-redView Bounds-")
        print("origin : \(redView.bounds.origin)")
        
        print("")
        print("-blueView Bounds-")
        print("origin : \(blueView.bounds.origin)")
    }
    
    @IBAction func didTouchChangeButton(_ sender: UIButton) {
        
    }


}

