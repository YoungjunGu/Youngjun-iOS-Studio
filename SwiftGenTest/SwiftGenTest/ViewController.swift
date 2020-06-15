//
//  ViewController.swift
//  SwiftGenTest
//
//  Created by youngjun goo on 2020/05/25.
//  Copyright © 2020 youngjun goo. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var blueView: UIView?
    @IBOutlet weak var redView: UIView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        blueView?.backgroundColor = Asset.gakiBlue.color
        redView?.backgroundColor = Asset.gakiRed.color
    }
    
    
}

