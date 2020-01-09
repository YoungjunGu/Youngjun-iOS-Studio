//
//  main.swift
//  MonadExam
//
//  Created by youngjun goo on 2019/10/07.
//  Copyright © 2019 youngjun goo. All rights reserved.
//

import Foundation



func addThree(_ num: Int) -> Int {
    return num + 3
}


print(addThree(2))
Optional(2).map(addThree)


var value: Int? = 2

value.map{ $0 + 3 } // optioanl
