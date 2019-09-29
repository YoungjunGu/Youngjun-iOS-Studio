//
//  ViewController.swift
//  UIViewAndLayer
//
//  Created by youngjun goo on 29/09/2019.
//  Copyright © 2019 youngjun goo. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var isChanged = false
    
    var shadowView: UIView = {
        let view = UIView()
        view.backgroundColor = .darkGray
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    var blueLayer: CALayer = {
        let layer =  CALayer()
        layer.backgroundColor = CGColor(srgbRed: 0.5, green: 0.3, blue: 0.1, alpha: 1.0)
        return layer
    }()
    
    var yellowLayer = CALayer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // blueLayer를 shadowView에 추가한다.
        shadowView.layer.addSublayer(blueLayer)
        blueLayer.frame = CGRect(x: shadowView.bounds.origin.x, y: shadowView.bounds.origin.y, width: 100, height: 100)
        blueLayer.backgroundColor =  CGColor(srgbRed: 0, green: 0, blue: 0.5, alpha: 1.0)
        
        // yellowLayer를 blueLayer에 SubLayer로 추가한다.
        blueLayer.addSublayer(yellowLayer)
        yellowLayer.frame.origin.x = 0
        yellowLayer.frame.origin.y = 0
        yellowLayer.frame.size.width = 50
        yellowLayer.frame.size.height = 50
        yellowLayer.backgroundColor = CGColor(srgbRed: 0.5, green: 0.5 , blue: 0, alpha: 1.0)
        
        // shadowView를 rootView에 추가한다.
        self.view.addSubview(shadowView)
        shadowView.widthAnchor.constraint(equalToConstant: 300).isActive = true
        shadowView.heightAnchor.constraint(equalToConstant: 300).isActive = true
        shadowView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        shadowView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true
        shadowView.layer.shadowRadius = 20
        shadowView.layer.shadowOpacity = 1
        shadowView.layer.shadowColor = UIColor.black.cgColor
        shadowView.layer.cornerRadius = 20
        
    }
    
    @IBAction func changeButtonDidTouch(_ sender: UIButton) {
        if !isChanged {
            self.shadowView.widthAnchor.constraint(equalToConstant: 200).isActive = true
            self.shadowView.heightAnchor.constraint(equalToConstant: 200).isActive = true
            isChanged = true
        } else {
            shadowView.widthAnchor.constraint(equalToConstant: 300).isActive = true
            shadowView.heightAnchor.constraint(equalToConstant: 300).isActive = true
            isChanged = false
        }

        shadowView.layoutIfNeeded()
    }
}

