//
//  HeaderView.swift
//  CustomerHeader
//
//  Created by youngjun goo on 11/01/2019.
//  Copyright © 2019 youngjun goo. All rights reserved.
//

import UIKit

class HeaderView: UICollectionReusableView {
    
    let imageView: UIImageView = {
        let imageSetView = UIImageView(image: #imageLiteral(resourceName: "Rony"))
        imageSetView.contentMode = .scaleAspectFill
        return imageSetView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    
        backgroundColor = .red
        
        addSubview(imageView)
        
        topAnchor
        leadingAnchor
        trailingAnchor
        bottomAnchor
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) 가 구현되지 않았습니다.")
    }
    
}
