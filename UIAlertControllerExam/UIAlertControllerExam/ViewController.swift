//
//  ViewController.swift
//  UIAlertControllerExam
//
//  Created by youngjun goo on 2019/10/05.
//  Copyright © 2019 youngjun goo. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    
    var alert: UIAlertController = UIAlertController()
    var cancel: UIAlertAction = UIAlertAction()

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func tapLoginButton(_ sender: UIButton) {
        let title = "iTunes Store에 로그인"
        let message = "사용자 로그인 정보를 입력하세요"
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let cancel = UIAlertAction(title: "취소", style: .cancel, handler: nil)
        let ok = UIAlertAction(title: "확인", style: .default) { (_) in
            let loginId = alert.textFields?[0].text
            let loginPw = alert.textFields?[1].text
            
            // ...
        }
        alert.addAction(cancel)
        alert.addAction(ok)
        
        alert.addTextField { (idTf) in
            idTf.placeholder = "아이디"
            idTf.isSecureTextEntry = false
        }

        alert.addTextField { (pwTf) in
            // 플레이스 홀더 설정
            pwTf.placeholder = "암호"
            // 비밀 번호 표기
            pwTf.isSecureTextEntry = true
        }
        
        self.present(alert, animated: false)
    }


}

