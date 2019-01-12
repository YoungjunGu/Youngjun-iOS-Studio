//
//  StretchyHeaderLayout.swift
//  CustomerHeader
//
//  Created by youngjun goo on 12/01/2019.
//  Copyright © 2019 youngjun goo. All rights reserved.
//

import UIKit

class StretchyHeaderLayout: UICollectionViewFlowLayout {

    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        
        let layoutAttributes = super.layoutAttributesForElements(in: rect)
        
        layoutAttributes?.forEach({ (attributes) in
            
            if attributes.representedElementKind == UICollectionView.elementKindSectionHeader && attributes.indexPath.section == 0 {
                
                guard let collectionView = collectionView else {
                    return
                }
                //스크롤 뷰의 origin 에서 offset 크기를 반환 y 값은 스크롤을 내릴때 멀어지는 y 값의 크기가 된다.
                let contentOffSetY = collectionView.contentOffset.y
                
                //헤더 뷰가 offset 값이 0 즉 헤더의 위치에 붙어있을때 는 그냥 return 을 통해 셀과 독립되게한다.
                if contentOffSetY > 0 {
                    return
                }
                
                let width = collectionView.frame.width
                //핵심: 높이를 떨어지는 offset(음수의 값이기 때문에) 스크롤을 내릴때 헤더뷰가 확대가 되기 위해서는
                //- contentOffSetY를 해주어야 한다.
                let height = attributes.frame.height - contentOffSetY
                //Header 프레임 세팅
                attributes.frame = CGRect(x: 0, y: contentOffSetY, width: width, height: height)
            }
        })
        return layoutAttributes
    }
    override func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
        return true
    }
}
