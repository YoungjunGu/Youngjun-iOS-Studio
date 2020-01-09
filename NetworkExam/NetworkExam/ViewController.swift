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
        
        imgBtn()
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    func imgBtn(){
        print("a-btn3")
        let img = UIImage(named:"1.jpg")
        let data = img?.jpegData(compressionQuality: 1.0)
        
        let url = "http://swiftapi.rubypaper.co.kr:2029/practice/echo"
        let headers: HTTPHeaders = [
            "Content-type": "multipart/form-data"
        ]
        
        AF.upload(multipartFormData: { (multipartFormData) in
                        if let data2 = data{
                multipartFormData.append(data2, withName: "image", fileName: "image.jpg", mimeType: "image/png")

            }
        }, usingThreshold: UInt64.init(), to: url, method: .post, headers: headers, interceptor: <#T##RequestInterceptor?#>)
        
        AF.upload(multipartFormData: { (multipartFormData) in
            /*for (key, value) in parameters{
             multipartFormData.append("\(value)".data(using: String.Encoding.utf8)!, withName: key as String)
             }*/
            if let data2 = data{
                multipartFormData.append(data2, withName: "image", fileName: "image.jpg", mimeType: "image/png")
                
            }
        }, usingThreshold: UInt64.init(), to: url, method: .post, headers: headers, interceptor: .none) { (result) in
            switch result{
            case .success(let upload, _, _):
                upload.responseJSON{ response in
                    print("Success")
                    if let err = response.error{
                        print("에러1")
                        return
                    }
                    
                }
            case .failure(let error):
                print("에러2")
            }
        }
    }
}

