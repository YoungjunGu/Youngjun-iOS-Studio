//
//  ViewController.swift
//  DelegatePatternExam
//
//  Created by youngjun goo on 23/03/2019.
//  Copyright © 2019 youngjun goo. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var commentView: CommentView?

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        commentView = CommentView(frame: CGRect(origin: .zero, size: CGSize(width: 300, height: 200)))
        if let commentView = commentView {
            commentView.frame.origin = CGPoint(x: (UIScreen.main.bounds.width - commentView.bounds.width) * 0.5, y: (UIScreen.main.bounds.height - commentView.bounds.height) * 0.5)
            
            commentView.backgroundColor = UIColor.lightGray
            commentView.delegate = self
        }
    }


}

extension ViewController: CommentViewDelegate {
    func touchUpCommentButton() {
        print("touchButton")
    }

}
