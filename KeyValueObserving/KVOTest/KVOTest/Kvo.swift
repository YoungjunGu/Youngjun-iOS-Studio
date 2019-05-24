//
//  Kvo.swift
//  KVOTest
//
//  Created by youngjun goo on 24/05/2019.
//  Copyright © 2019 youngjun goo. All rights reserved.
//

import Foundation


@objcMembers class Time: NSObject {
    dynamic var stopWatch: Date
    
    init(stopWatch: Date) {
        self.stopWatch = stopWatch
    }
}

// Objective-C 런타임에서 구동이 되기 때문에 NSObject 상속해야한다.
// @objcMembers 키워드를 클래스 앞에 선언 하게 되면 dynamic 키워드 앞에 @obj 키워드를 생략 할 수 있다.
class TimeManager {
    // 감지할 객체앞에 'dynamic' 키워드를 붙인다.
    var time: Time
    // dateformmating 해주는 함수
    lazy var dateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy:MM:dd HH:mm:ss"
        return dateFormatter
    }()
    
    var stopWatch: String {
        return dateFormatter.string(from: time.stopWatch)
    }
    
    init(_ time: Time) {
        self.time = time
    }
    
    func stopTheWatch() {
        time.stopWatch = Date()
    }
    
}
