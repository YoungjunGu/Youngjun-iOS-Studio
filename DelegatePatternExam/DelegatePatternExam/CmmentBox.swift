//
//  CmmentBox.swift
//  DelegatePatternExam
//
//  Created by youngjun goo on 23/03/2019.
//  Copyright © 2019 youngjun goo. All rights reserved.
//

import UIKit

protocol CommentViewDelegate: class {
    func touchUpCommentButton()
}

class CommentView: UIView {
    
    weak var delegate: CommentViewDelegate?
    var commentButton: UIButton?
    var commentTextField: UITextField?

    public override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        configure()
    }
    func configure() {
        commentButton = UIButton(type: .system)
        if let button = commentButton {
            button.setTitle("comment", for: .normal)
            button.sizeToFit()
            button.frame.origin = CGPoint(x: (self.bounds.width - button.bounds.width) * 0.5,
                                       y: (self.bounds.height - button.bounds.height) * 0.5)
            button.addTarget(self, action: #selector(tapButton), for: .touchUpInside)
            self.addSubview(button)
        }
        commentTextField = UITextField()
        if let textField = commentTextField {
            textField.sizeToFit()
            textField.frame.origin = CGPoint(x: (self.bounds.width - textField.bounds.width) * 0.5,
                                             y: (self.bounds.height - textField.bounds.height) * 0.5)
            
            self.addSubview(textField)
        }
    }
    @objc func tapButton() {
        delegate?.touchUpCommentButton()
    }
}
