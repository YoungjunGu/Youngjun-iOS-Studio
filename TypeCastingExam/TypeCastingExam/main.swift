//
//  main.swift
//  TypeCastingExam
//
//  Created by youngjun goo on 2019/10/02.
//  Copyright © 2019 youngjun goo. All rights reserved.
//

import Foundation

let library = [

    Movie(name: "어벤져스: 엔드게임", director: "안소니 루소"),
    
    Song(name: "Viva La Vida", artist: "콜드플레이"),
    
    Movie(name: "스파이더맨: 파프롬홈", director: "존 왓츠"),
    
    Movie(name: "기생충", director: "봉준호"),
    
]


var groups = [Any]()
groups.append(1.0)
groups.append(1)
groups.append("string")
groups.append((3.0, 5.0))
groups.append(Movie(name: "조커", director: "토드 필립스"))
groups.append({ (name: String) -> String in "hello my name is \(name)"})

for item in groups {
    switch item {
    case let anInt as Int:
        print("\(anInt) is an int")
    case let aDouble as Double:
        print("\(aDouble) is a double")
    case let aString as String:
        print("\(aString) is a string")
    case let (x, y) as (Double, Double) :
        print("x좌표 : \(x), y좌표: \(y)")
    case let movie as Movie:
        print("영화정보 입력> 제목 : \(movie.name), 감독 : \(movie.director)")
    case let introduceClosure as (String) -> String :
        print(introduceClosure("Gaki"))
    default:
        print("so on")
    }
}




 
