//
//  ViewController.swift
//  NetworkExam
//
//  Created by youngjun goo on 06/03/2019.
//  Copyright © 2019 youngjun goo. All rights reserved.
//

import UIKit
import Alamofire

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let url = "http://swiftapi.rubypaper.co.kr:2029/practice/currentTime"
        AF.request(url).responseString() { response in
            print("성공여부: \(response.result.isSuccess)")
            print("결과값 : \(response.result.value!)")
        }
     
        // Do any additional setup after loading the view, typically from a nib.
    }


}

