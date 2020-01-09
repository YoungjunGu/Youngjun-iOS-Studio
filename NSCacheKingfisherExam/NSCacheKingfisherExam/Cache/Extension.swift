//
//  Extension.swift
//  NSCacheKingfisherExam
//
//  Created by youngjun goo on 2019/10/10.
//  Copyright © 2019 youngjun goo. All rights reserved.
//

import UIKit


extension UIImage {
    // NSCache key-value 타입의 객체 생성
    static let imageCache = NSCache<AnyObject, AnyObject>()
    
    // escaping closure룰 통해 성공한 UIImage를 반환
    static func cacheImage(from endPoint: String, completion: @escaping (UIImage?) ->()) {
        
        
    }
}
