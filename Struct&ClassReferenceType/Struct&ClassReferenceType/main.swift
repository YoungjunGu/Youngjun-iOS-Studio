//
//  main.swift
//  Struct&ClassReferenceType
//
//  Created by youngjun goo on 2019/10/04.
//  Copyright © 2019 youngjun goo. All rights reserved.
//

import Foundation

struct BasicInformation {
    let name: String
    var age: Int
}

var gakiInfo: BasicInformation = BasicInformation(name: "Gaki", age: 25)
gakiInfo.age = 100

var gakiClone: BasicInformation = gakiInfo
gakiClone.age = 25

print(gakiInfo.age)     // 100
print(gakiClone.age)    // 25

//func getOld(_ info: BasicInformation) {
//    info.age += 1
//}

// getOld(gakiInfo)

print(gakiInfo.age)



class Developer {
    // var로 프로퍼티를 선언하고 초기화를 하지 않으면 initialize를 해야한다고 경고가 뜬다.
    var stack: String = "iOS Developer"
    var career: Int = 1
}

var gaki: Developer = Developer()
var clone: Developer = gaki

print("gaki는 \(gaki.stack) 입니다.")
print("clone은 \(clone.stack) 입니다.")

clone.stack = "Android Developer"

print("gaki는 \(gaki.stack) 입니다.")


func growwUpCareer(_ developer: Developer) {
    developer.career += 1
}

growwUpCareer(gaki)

print(gaki.career)

print(gaki === clone)
