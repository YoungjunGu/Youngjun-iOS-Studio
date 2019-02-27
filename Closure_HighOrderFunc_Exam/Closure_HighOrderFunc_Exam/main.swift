//
//  main.swift
//  Closure_HighOrderFunc_Exam
//
//  Created by youngjun goo on 27/02/2019.
//  Copyright © 2019 youngjun goo. All rights reserved.
//

import Foundation

//let names: [String] = ["x", "c", "b", "a", "k"]
//
//func backwards(first: String, second: String) -> Bool {
//    print("\(first) \(second) 비교중")
//    return first < second
//}
//
//let reversed: [String] = names.sorted(by: backwards)
//print(reversed)
//
//
//
//
//let reversed2: [String] = names.sorted(by: { (first: String, second: String) -> Bool in
//    return first < second
//})
//
//print(reversed2)



// 함수 외부에 클로저를 저장하는 예시
// 클로저를 저장하는 배열
var completionHandlers: [() -> Void] = []

func withEscaping(completion: @escaping () -> Void) {
    // 함수 밖에 있는 completionHandlers 배열에 해당 클로저를 저장
    completionHandlers.append(completion)
}

func withoutEscaping(completion: () -> Void) {
    completion()
}

class MyClass {
    var x = 10
    func callFunc() {
        withEscaping { self.x = 100 }
        withoutEscaping { x = 200 }
    }
}
let mc = MyClass()
mc.callFunc()
print(mc.x)
completionHandlers.first?()
print(mc.x)


class Server {
    static var users: [UserModel] = []
    
    static getUser(completion: @escaping (Bool, [UserModel]) -> Void) {
        //2
        Alamofire.request(urlRequest).responseJSON { reponse in
            users.append(유저)
            DispatchQueue.main.async {
                //3
                completion(true, users)
            }
        }
    }
}

//1
Server.getUser{ (isSuccess, users) in
    //4
    if isSuccess {
    //성공했기 때문에 UI Update 작업 수행
    }
}
