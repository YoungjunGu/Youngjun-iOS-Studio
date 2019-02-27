//
//  DispatchQueueExam.swift
//  ConcurrencyProg
//
//  Created by youngjun goo on 26/02/2019.
//  Copyright © 2019 youngjun goo. All rights reserved.
//

import Foundation


let serialQueue = DispatchQueue(label: "com.example.serial")

serialQueue.async {
    for i in 0..<10 {
        print("🍏", i)
    }
}
serialQueue.async {
    for i in 100..<110 {
        print("🍎", i)
    }
}
