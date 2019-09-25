//
//  ViewController.swift
//  ExpandViewAnimation
//
//  Created by youngjun goo on 25/09/2019.
//  Copyright © 2019 youngjun goo. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var blueView: UIView!
    private var isTouched: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(tapBlueView(gestureRecognizer:)))
        self.blueView.addGestureRecognizer(tapRecognizer)
        
    }
    
    @objc func tapBlueView(gestureRecognizer: UIGestureRecognizer) {
//        let viewWidth = view.frame.width
//        let viewHeight = view.frame.height
//        UIView.animate(withDuration: 1) {
//            self.blueView.frame = CGRect(x: 0, y: 0, width: viewWidth, height: viewHeight)
//        }
        
        if(self.isTouched == false) {

            let screenCenter = CGPoint(x:UIScreen.main.bounds.midX, y: UIScreen.main.bounds.midY)
            let subviewCenter = self.view.convert(self.blueView.center, to: self.view)
            let offset = UIOffset(horizontal: screenCenter.x-subviewCenter.x, vertical: screenCenter.y-subviewCenter.y)

            let widthScale = UIScreen.main.bounds.size.width/blueView.frame.size.width
            let heightScale = UIScreen.main.bounds.size.height/blueView.frame.size.height
            UIView.animate(withDuration: 1.0, animations: {
                let scaleTransform = CGAffineTransform(scaleX: widthScale, y: heightScale)
                let translateTransform = CGAffineTransform(translationX: offset.horizontal, y: offset.vertical)
                self.blueView.transform = scaleTransform.concatenating(translateTransform)
            }, completion: { (finished) in
                self.isTouched = true
            })

        } else {
            UIView.animate(withDuration: 1.0, animations: {
                self.blueView.transform = CGAffineTransform.identity
            }, completion: { (finished) in
                self.isTouched = false
            })
        }
    }


}

