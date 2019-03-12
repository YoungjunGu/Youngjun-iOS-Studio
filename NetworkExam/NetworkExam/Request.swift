//
//  Request.swift
//  NetworkExam
//
//  Created by youngjun goo on 06/03/2019.
//  Copyright © 2019 youngjun goo. All rights reserved.
//

import Foundation
import Alamofire



let parameters: Parameters = [
    "name": "gaki",
    "age": 25
]

func requestAPI() {
 
    let alamo = AF.request("http://url.com/post",
                           method: .post,
                           parameters: parameters,
                           encoding: URLEncoding.httpBody)
    alamo.responseJSON() { response in
        print("JSON = \(response.result.value!)")
        if let jsonObject = response.value as? Parameters {
            print("name = \(jsonObject["name"]!)")
            print("age = \(jsonObject["age"]!)")
        }
    }
}




