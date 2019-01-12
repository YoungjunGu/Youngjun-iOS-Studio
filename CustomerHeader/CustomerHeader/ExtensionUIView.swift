//
//  ExtensionUIView.swift
//  CustomerHeader
//
//  Created by youngjun goo on 12/01/2019.
//  Copyright © 2019 youngjun goo. All rights reserved.
//

import UIKit

struct AnchoredConstraints {
    var top, leading, bottom, trailing, width, heingt: NSLayoutConstraint?
}

extension UIView {
    
    func fillSuperView() {
        anchor(top: superview?.topAnchor, leading: superview?.leadingAnchor, bottom: superview?.bottomAnchor, trailing: superview?.trailingAnchor)
    }
    
    func anchorSize(to view: UIView) {
        widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        heightAnchor.constraint(equalTo: view.heightAnchor).isActive = true
    }
    
    @discardableResult
    func anchor(top: NSLayoutYAxisAnchor?, leading: NSLayoutXAxisAnchor?, bottom: NSLayoutYAxisAnchor?,
                trailing: NSLayoutXAxisAnchor?, padding: UIEdgeInsets = .zero, size: CGSize = .zero)
        -> AnchoredConstraints {
            
            translatesAutoresizingMaskIntoConstraints = false
            var anchorConstraints = AnchoredConstraints()
            
            if let top = top {
                anchorConstraints.top = topAnchor.constraint(equalTo: top, constant: padding.top)
            }
            if let leading = leading {
                anchorConstraints.leading = leadingAnchor.constraint(equalTo: leading, constant: padding.left)
            }
            if let bottom = bottom {
                anchorConstraints.bottom = bottomAnchor.constraint(equalTo: bottom, constant: -padding.bottom)
            }
            if let trailing = trailing {
                anchorConstraints.trailing =  trailingAnchor.constraint(equalTo: trailing, constant: -padding.right)
            }
            if size.width != 0 {
                anchorConstraints.width = widthAnchor.constraint(equalToConstant: size.width)
            }
            if size.height != 0 {
                anchorConstraints.heingt = heightAnchor.constraint(equalToConstant: size.height)
            }
            //클로저를 활용하여 모든 항목에 대해 isActive 프로퍼티 true로 초기화
            [anchorConstraints.top, anchorConstraints.leading, anchorConstraints.bottom, anchorConstraints.trailing, anchorConstraints.width, anchorConstraints.heingt].forEach{
                $0?.isActive = true
            }
            return anchorConstraints
    }
    
}
