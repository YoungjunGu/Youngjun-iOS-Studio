//
//  ViewController.swift
//  ARCTest
//
//  Created by youngjun goo on 23/05/2019.
//  Copyright © 2019 youngjun goo. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        var terran: Tribe?
        var marine: Unit?
        
        terran = Tribe(name: "Terran")
        marine = Unit(name: "Marine")
        
        // 1.
        terran?.unit = marine
        // 2.
        marine?.tribe = terran
        
        // 3.
        terran = nil
        // 4.
        marine = nil
        
        
    }


}

