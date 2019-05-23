//
//  Unit.swift
//  ARCTest
//
//  Created by youngjun goo on 23/05/2019.
//  Copyright © 2019 youngjun goo. All rights reserved.
//

import Foundation

class Unit {
    let name: String
    
    init(name: String) {
        self.name = name
        print("\(name) 이 initializing 되었습니다.")
    }
    var tribe: Tribe?
    deinit {
        print("\(name) 이 deinitializeing 되었습니다.  ")
    }
}

class Tribe {
    // 종족
    let name: String
    
    init(name: String) {
        self.name = name
        print("\(name) 이 initializing 되었습니다.")
    }
    weak var unit: Unit?
    deinit {
        print("\(name) 이 deinitializeing 되었습니다.  ")
    }
}
